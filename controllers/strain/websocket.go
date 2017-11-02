package strain

import (
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
		_, _, err := ws.ReadMessage()
		if err != nil {
			return
		}
		publish <- newEvent(sockets.EVENT_INCREASE, uname, wound, strain, ws_type)
	}

}

func (this *WebSocketController) Subs() {
	var subs = make([]PSub, 0)
	for sub := subscribers.Front(); sub != nil; sub = sub.Next() {
		if sub.Value.(Subscriber).Type == "play" {
			psub := PSub{Name: sub.Value.(Subscriber).Name, Wound: sub.Value.(Subscriber).Wound, Strain: sub.Value.(Subscriber).Strain, Type: sub.Value.(Subscriber).Type}
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

	for sub := subscribers.Front(); sub != nil; sub = sub.Next() {
		// Immediately send event to WebSocket users.
		ws := sub.Value.(Subscriber).Conn
		if ws != nil && sub.Value.(Subscriber).Type == "watch" {
			if ws.WriteMessage(websocket.TextMessage, data) != nil {
				// User disconnected.
				unsubscribe <- sub.Value.(Subscriber).Name
			}
		}
	}
}
