package gamesocket

import (
	"encoding/json"
	"github.com/gorilla/websocket"
	"net/http"
)

func Upgrade(w http.ResponseWriter, r *http.Request) (*websocket.Conn, error) {
	// webUpg := websocket.Upgrader{ReadBufferSize: 1024, WriteBufferSize: 1024}
	// ws, err := webUpg.Upgrade(w, r, nil)
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
		send := event.sendAll
		if !send {
			if subscribers[i].Type == SUB_WATCH {
				send = true
				data = buildSockMessage(event)
			} else if subscribers[i].Type == SUB_MASTER && event.Type != EVENT_NOTE && (subscribers[i].Id != event.Sender.Id || event.Type == EVENT_JOIN){
				send = true
				data = buildSockMessage(event)
			} else {
				for j := 0; j < len(event.Targets); j++ {
					if subscribers[i].Id == event.Targets[j] {
						send = true
						sockMes := SocketMessage{Type: event.Type, Player: event.Sender}
						var multData MultiMess
						if err := json.Unmarshal([]byte(event.Data), &multData); err == nil {
							sockMes.Data = multData.Message
						} else {
							sockMes.Data = event.Data
						}
						data, _ = json.Marshal(sockMes)
						break
					}
				}
			}
		} else {
			data = buildSockMessage(event)
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
	}
}

func buildSockMessage(event Event) []byte {
	sockMes := SocketMessage{Type: event.Type, Player: event.Sender, Data: event.Data}
	data, _ := json.Marshal(sockMes)
	return data
}
