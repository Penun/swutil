package strain

import (
	"time"
	"encoding/json"
	"strconv"
	"net/http"
	"github.com/astaxie/beego"
	"github.com/gorilla/websocket"
	"github.com/Penun/swutil/models/sockets"
)

// WebSocketController handles WebSocket requests.
type WebSocketController struct {
	beego.Controller
}

type GetSubsResp struct {
    Players []PSub `json:"Players"`
}

type AdjustReq struct {
	Threshold int64 `json:"thresh"`
	Direction int64 `json:"direction"`
}

type PSub struct {
	Name string `json:"Name"`
    Wound int64 `json:"Wound"`
    Strain int64 `json:"Strain"`
    Type string `json:"Type"`
}

func (this *WebSocketController) Get() {
	this.TplName = "strain/index.tpl"
}

func (this *WebSocketController) Watch() {
	this.TplName = "strain/watch.tpl"
}

// Join method handles WebSocket requests for WebSocketController.
func (this *WebSocketController) Join() {
	uname := ""
	var wound int64
	var strain int64
	ws_type := this.GetString("type")
	if ws_type == "play" {
		uname = this.GetString("uname")
		w := this.GetString("wound")
		wound, _ = strconv.ParseInt(w, 10, 64)
		s := this.GetString("strain")
		strain, _ = strconv.ParseInt(s, 10, 64)
		if len(uname) == 0 || wound <= 0 || strain <= 0 {
			this.Redirect("/", 302)
			return
		}
	} else if ws_type == "watch" {
		uname = "watch" + strconv.FormatInt(time.Now().Unix(), 10)
	} else {
		this.Redirect("/", 302)
		return
	}

	this.TplName = "strain/end.html"

	// Upgrade from http request to WebSocket.
	ws, err := websocket.Upgrade(this.Ctx.ResponseWriter, this.Ctx.Request, nil, 1024, 1024)
	if _, ok := err.(websocket.HandshakeError); ok {
		http.Error(this.Ctx.ResponseWriter, "Not a websocket handshake", 400)
		return
	} else if err != nil {
		beego.Error("Cannot setup WebSocket connection:", err)
		return
	}

	// Join chat room.
	Join(uname, wound, strain, ws_type, ws)
	defer Leave(uname)

	// Message receive loop.
	for {
		_, adj, err := ws.ReadMessage()
		if err != nil {
			return
		}
		var adjReq AdjustReq
		err = json.Unmarshal(adj, &adjReq)
		if err == nil {
			var addVal int64
			if adjReq.Direction == 1 {
				addVal = 1
			} else {
				addVal = -1
			}

			for i := 0; i < len(subscribers); i++ {
				if subscribers[i].Name == uname {
					if (adjReq.Threshold == 1){
						wound += addVal
						subscribers[i].Wound += addVal
					} else {
						strain += addVal
						subscribers[i].Strain += addVal
					}
					break
				}
			}
		}
		publish <- newEvent(sockets.EVENT_ADJUST, uname, wound, strain, ws_type)
	}

}

func (this *WebSocketController) Subs() {
	var subs = make([]PSub, 0)
	for i := 0; i < len(subscribers); i++ {
		if subscribers[i].Type == "play" {
			psub := PSub{Name: subscribers[i].Name, Wound: subscribers[i].Wound, Strain: subscribers[i].Strain, Type: subscribers[i].Type}
			subs = append(subs, psub)
		}
	}
	resp := GetSubsResp{Players: subs}
	this.Data["json"] = resp
	this.ServeJSON()
}

// broadcastWebSocket broadcasts messages to WebSocket users.
func broadcastWebSocket(event sockets.Event) {
	data, err := json.Marshal(event)
	if err != nil {
		beego.Error("Fail to marshal event:", err)
		return
	}

	for i := 0; i < len(subscribers); i++ {
		// Immediately send event to WebSocket users.
		ws := subscribers[i].Conn
		if ws != nil && subscribers[i].Type == "watch" {
			if ws.WriteMessage(websocket.TextMessage, data) != nil {
				// User disconnected.
				unsubscribe <- subscribers[i].Name
			}
		}
	}
}
