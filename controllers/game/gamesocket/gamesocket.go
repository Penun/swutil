package gamesocket

import (
	"encoding/json"
	"github.com/gorilla/websocket"
	"net/http"
	"github.com/astaxie/beego"
)

func Upgrade(w http.ResponseWriter, r *http.Request) (*websocket.Conn, error) {
	ws, err := websocket.Upgrade(w, r, nil, 1024, 1024)
	if err != nil {
		return nil, err
	}
	return ws, nil
}

// broadcastWebSocket broadcasts messages to WebSocket users.
func broadcastWebSocket(event Event) {
	for i := 0; i < len(subscribers); i++ {
		var data []byte
		send := false
		if subscribers[i].Watch && (event.Type == 0 || subscribers[i].Id != event.Sender.Id) {
			beego.Info("Event Type", event.Type)
			beego.Info("Sub Id", subscribers[i].Id)
			beego.Info("Sender Id", event.Sender.Id)
			beego.Info("")
			send = true
			sockMes := SocketMessage{Type: event.Type, Player: event.Sender, Data: event.Data}
			data, _ = json.Marshal(sockMes)
		} else {
			for j := 0; j < len(event.Targets); j++ {
				if subscribers[i].Id == event.Targets[j] {
					send = true
					sockMes := SocketMessage{Type: event.Type, Player: event.Sender}
					var multData MultiMess
					if err := json.Unmarshal([]byte(event.Data), multData); err == nil {
						sockMes.Data = multData.Message
					} else {
						sockMes.Data = event.Data
					}
					data, _ = json.Marshal(sockMes)
					break
				}
			}
		}
		if send {
			ws := subscribers[i].Conn
			if ws != nil {
				if ws.WriteMessage(websocket.TextMessage, data) != nil {
					// User disconnected.
					unsubscribe <- subscribers[i].Id
				}
			}
		}

		// send := false
		// watch := subscribers[i].Type == "watch"
		// switch event.Type {
		// case EVENT_JOIN:
		// 	send = true
		// case EVENT_LEAVE:
		// 	if event.Sender.Type == "master" {
		// 		if event.Data == "" {
		// 			send = true
		// 		} else if watch {
		// 			send = true
		// 		}
		// 	} else {
		// 		send = true
		// 	}
		// case EVENT_NOTE:
		// 	send = FindInSlice(event.Targets, subscribers[i])
		// case EVENT_INIT:
		// 	if watch {
		// 		send = true
		// 	} else if subscribers[i].Type == "master" && event.Sender.Type != "master" {
		// 		send = true
		// 	} else {
		// 		send = FindInSlice(event.Targets, subscribers[i])
		// 	}
		// case EVENT_WOUND:
		// 	if watch {
		// 		send = true
		// 	} else if subscribers[i].Type == "master" && event.Sender.Type != "master" {
		// 		send = true
		// 	} else {
		// 		send = FindInSlice(event.Targets, subscribers[i])
		// 	}
		// case EVENT_STRAIN:
		// 	if watch {
		// 		send = true
		// 	} else if subscribers[i].Type == "master" && event.Sender.Type != "master" {
		// 		send = true
		// 	} else {
		// 		send = FindInSlice(event.Targets, subscribers[i])
		// 	}
		// case EVENT_INIT_S:
		// 	if subscribers[i].Type != "master" {
		// 		send = true
		// 	}
		// case EVENT_INIT_T:
		// 	if watch {
		// 		send = true
		// 	}
		// case EVENT_INIT_E:
		// 	if subscribers[i].Type != "master" {
		// 		send = true
		// 	}
		// case EVENT_BOOST:
		// 	if watch {
		// 		send = true
		// 	}
		// case EVENT_SETBACK:
		// 	if watch {
		// 		send = true
		// 	}
		// case EVENT_UPGRADE:
		// 	if watch {
		// 		send = true
		// 	}
		// case EVENT_UPDIFF:
		// 	if watch {
		// 		send = true
		// 	}
		// case EVENT_TEAM:
		// 	if watch {
		// 		send = true
		// 	} else {
		// 		send = FindInSlice(event.Targets, subscribers[i])
		// 	}
		// }
		//
		// if send {
		// 	var data []byte
		// 	if !watch {
		// 		sockMes := SocketMessage{Type: event.Type, Player: event.Sender, Data: event.Data}
		// 		data, _ = json.Marshal(sockMes)
		// 	} else {
		// 		sockMes := SocketWatchMessage{Type: event.Type, Player: event.Sender, Players: event.Targets, Data: event.Data}
		// 		data, _ = json.Marshal(sockMes)
		// 	}
		// 	if len(data) == 0 {
		// 		return
		// 	}
		// 	ws := subscribers[i].Conn
		// 	if ws != nil {
		// 		if ws.WriteMessage(websocket.TextMessage, data) != nil {
		// 			// User disconnected.
		// 			unsubscribe <- subscribers[i].Name
		// 		}
		// 	}
		// }
	}
}

// func FindInSlice(targets []int, sub Subscriber) bool {
// 	for i := 0; i < len(targets); i++ {
// 		for var j := 0; j <
// 		if targets[i] == sub.Name {
// 			return true
// 		}
// 	}
// 	return false
// }
