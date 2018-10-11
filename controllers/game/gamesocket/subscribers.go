package gamesocket

import (
	"github.com/astaxie/beego"
	"github.com/gorilla/websocket"
)

type Subscription struct {
	Archive []Event      // All the events from the archive.
	New     <-chan Event // New events coming in.
}

type Subscriber struct {
	Name string `json:"Name"`
    Type string `json:"Type"`
	Conn *websocket.Conn `json:"Conn"`// Only for WebSocket users; otherwise nil.
}

var (
	// Channel for new join users.
	subscribe = make(chan Subscriber, 10)
	// Channel for exit users.
	unsubscribe = make(chan string, 10)
	// Send events here to publish them.
	Publish = make(chan Event, 10)
	subscribers = make([]Subscriber, 0)
)

// This function handles all incoming chan messages.
func tracker() {
	for {
		select {
		case sub := <-subscribe:
			if !IfUserExist(sub.Name) {
				subscribers = append(subscribers, sub) // Add user to the end of list.
				// Publish a JOIN event.
				Publish <- NewEvent(EVENT_JOIN, sub.Name, sub.Type, nil, "")
				beego.Info("New user:", sub.Name, ";WebSocket:", sub.Conn != nil)
			} else {
				beego.Info("Old user:", sub.Name, ";WebSocket:", sub.Conn != nil)
			}
		case event := <- Publish:
			broadcastWebSocket(event)
		case unsub := <-unsubscribe:
			subL := len(subscribers)
			for i := 0; i < subL; i++ {
				if subscribers[i].Name == unsub {
					ws := subscribers[i].Conn // Clone connection.
					if i == subL - 1 {
						subscribers = subscribers[:subL-1]
					} else {
						subscribers = append(subscribers[:i], subscribers[i+1:]...)
					}

					if ws != nil {
						ws.Close()
						beego.Error("WebSocket closed:", unsub)
					}
					break
				}
			}
		}
	}
}

func init() {
	go tracker()
}

func NewEvent(ep int, user string, ws_type string, targets []string, data string) Event {
	return Event{ep, Sender{user, ws_type}, targets, data}
}

func Join(user string, ws_type string, ws *websocket.Conn) {
	subscribe <- Subscriber{Name: user, Type: ws_type, Conn: ws}
}

func Leave(user string) {
	unsubscribe <- user
}

func IfUserExist(user string) bool {
	for i := 0; i < len(subscribers); i++ {
		if subscribers[i].Name == user {
			return true
		}
	}
	return false
}
