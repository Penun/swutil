package game

import (
	"time"
	"encoding/json"
	"strconv"
	"net/http"
	"github.com/astaxie/beego"
	"github.com/gorilla/websocket"
	"github.com/Penun/swutil/models/game"
)

// WebSocketController handles WebSocket requests.
type WebSocketController struct {
	beego.Controller
}

type ControllerReq struct {
	Type string `json:"type"`
	Data MultiMess `json:"data"`
}

type MultiMess struct {
    Players []string `json:"players"`
    Message string `json:"message"`
}

type SocketMessage struct {
	Type game.EventType `json:"type"`
	Player game.Sender `json:"player"`
	Data string `json:"data"`
}

type SocketWatchMessage struct {
	Type game.EventType `json:"type"`
	Player game.Sender `json:"player"`
	Players []string `json:"players"`
	Data string `json:"data"`
}

// Join method handles WebSocket requests for WebSocketController.
func (this *WebSocketController) Join() {
	uname := ""
	ws_type := this.GetString("type")
	var curPlay game.LivePlayer
	if ws_type == "play" {
		uname = this.GetString("uname")
		if len(uname) == 0 {
			this.Redirect("/", 302)
			return
		}
		for _, sub := range subscribers {
			if sub.Name == uname {
				this.Redirect("/", 302)
				return
			}
		}
		newPlay := game.Player{Name: uname}
		curPlay = game.LivePlayer{Player: &newPlay, Type: "PC"}
		players = append(players, &curPlay)
	} else if ws_type == "watch" {
		uname = "watch" + strconv.FormatInt(time.Now().Unix(), 10)
	} else {
		this.Redirect("/", 302)
		return
	}

	this.TplName = "game/end.html"

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
	Join(uname, ws_type, ws)
	defer SetupLeave(uname, curPlay)

	// Message receive loop.
	for {
		_, adj, err := ws.ReadMessage()
		if err != nil {
			return
		}
		var conReq ControllerReq
		err = json.Unmarshal(adj, &conReq)
		if err == nil {
			switch conReq.Type {
			case "note":
				publish <- newEvent(game.EVENT_NOTE, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "wound":
				wound, _ := strconv.Atoi(conReq.Data.Message)
				curPlay.Player.Wound += wound
				// this.SetSession("player", curPlay)
				publish <- newEvent(game.EVENT_WOUND, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "strain":
				strain, _ := strconv.Atoi(conReq.Data.Message)
				curPlay.Player.Strain += strain
				// this.SetSession("player", curPlay)
				publish <- newEvent(game.EVENT_STRAIN, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative":
				init, _ := strconv.ParseFloat(conReq.Data.Message, 64)
				curPlay.Initiative = init
				// this.SetSession("player", curPlay)
				SortPlayerInit()
				publish <- newEvent(game.EVENT_INIT, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative_t":
				if curInitInd == len(players) - 1 {
					curInitInd = 0
				} else {
					curInitInd++
				}
				publish <- newEvent(game.EVENT_INIT_T, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			}
		} else {
			beego.Error(err.Error())
		}
	}
}

func (this *WebSocketController) JoinM() {
	if !master{
		master = true
	} else {
		this.Redirect("/", 302)
		return
	}

	uname := "DM"
	ws_type := "master"

	this.TplName = "game/end.html"

	// Upgrade from http request to WebSocket.
	ws, err := websocket.Upgrade(this.Ctx.ResponseWriter, this.Ctx.Request, nil, 1024, 1024)
	if _, ok := err.(websocket.HandshakeError); ok {
		http.Error(this.Ctx.ResponseWriter, "Not a websocket handshake", 400)
		return
	} else if err != nil {
		beego.Error("Cannot setup WebSocket connection:", err)
		return
	}

	// Join update channel.
	Join(uname, ws_type, ws)
	defer SetupLeaveM(uname)

	// Message receive loop.
	for {
		_, req, err := ws.ReadMessage()
		if err != nil {
			return
		}

		var conReq ControllerReq
		err = json.Unmarshal(req, &conReq)
		if err == nil {
			switch conReq.Type {
			case "note":
				publish <- newEvent(game.EVENT_NOTE, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "wound":
				publish <- newEvent(game.EVENT_WOUND, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "strain":
				publish <- newEvent(game.EVENT_STRAIN, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative_d":
				publish <- newEvent(game.EVENT_INIT_D, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative_s":
				if initStarted {
					initStarted = false
				} else {
					initStarted = true
					curInitInd = 0
					SortPlayerInit()
				}
				publish <- newEvent(game.EVENT_INIT_S, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative_t":
				prevInitInd = curInitInd
				if conReq.Data.Message == "+" {
					if curInitInd == len(players) - 1 {
						curInitInd = 0
					} else {
						curInitInd++
					}
				} else {
					if curInitInd == 0 {
						curInitInd = len(players) - 1
					} else {
						curInitInd--
					}
				}
				publish <- newEvent(game.EVENT_INIT_T, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "add":
				var newPlay game.LivePlayer
				err = json.Unmarshal([]byte(conReq.Data.Message), &newPlay)
				if err == nil {
					newPlay.Type = "NPC"
					players = append(players, &newPlay)
					SortPlayerInit()
					publish <- newEvent(game.EVENT_JOIN, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
				} else {
					beego.Error(err.Error())
				}
			case "delete":
				var targs []game.Player
				err = json.Unmarshal([]byte(conReq.Data.Message), &targs)
				if err == nil {
					for i := 0; i < len(targs); i++ {
						for j := 0; j < len(players); j++ {
							if players[j].Player.Name == targs[i].Name {
								RemovePlayer(j)
								j--
							}
						}
					}
					SortPlayerInit()
					publish <- newEvent(game.EVENT_LEAVE, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
				} else {
					beego.Error(err.Error())
				}
			}
		} else {
			beego.Error(err.Error())
		}
	}
}

// broadcastWebSocket broadcasts messages to WebSocket users.
func broadcastWebSocket(event game.Event) {
	for i := 0; i < len(subscribers); i++ {
		send := false
		watch := subscribers[i].Type == "watch"
		switch event.Type {
		case game.EVENT_JOIN:
			if event.Sender.Type == "master" {
				if event.Data == "" {
					send = true
				} else if watch {
					send = true
				}
			} else if event.Sender.Type == "play" {
				send = true
			}
		case game.EVENT_LEAVE:
			if event.Sender.Type == "master" {
				if event.Data == "" {
					send = true
				} else if watch {
					send = true
				}
			} else {
				send = true
			}
		case game.EVENT_NOTE:
			send = FindInSlice(event.Targets, subscribers[i])
		case game.EVENT_INIT_D:
			if watch {
				send = true
			} else {
				send = FindInSlice(event.Targets, subscribers[i])
			}
		case game.EVENT_WOUND:
			if watch {
				send = true
			} else {
				send = FindInSlice(event.Targets, subscribers[i])
			}
		case game.EVENT_STRAIN:
			if watch {
				send = true
			} else {
				send = FindInSlice(event.Targets, subscribers[i])
			}
		case game.EVENT_INIT:
			if watch {
				send = true
			}
		case game.EVENT_INIT_S:
			if watch {
				send = true
			} else if len(players) > 0 && players[curInitInd].Player.Name == subscribers[i].Name {
				send = true
			}
		case game.EVENT_INIT_T:
			if watch {
				send = true
			} else if len(players) > 0 && players[curInitInd].Player.Name == subscribers[i].Name {
				send = true
			} else if event.Sender.Type == "master" && players[prevInitInd].Player.Name == subscribers[i].Name {
				send = true
			}
		}

		if send {
			var data []byte
			if !watch {
				sockMes := SocketMessage{Type: event.Type, Player: event.Sender, Data: event.Data}
				data, _ = json.Marshal(sockMes)
			} else {
				sockMes := SocketWatchMessage{Type: event.Type, Player: event.Sender, Players: event.Targets, Data: event.Data}
				data, _ = json.Marshal(sockMes)
			}
			if len(data) == 0 {
				return
			}
			ws := subscribers[i].Conn
			if ws != nil {
				if ws.WriteMessage(websocket.TextMessage, data) != nil {
					// User disconnected.
					unsubscribe <- subscribers[i].Name
				}
			}
		}
	}
}
