package strain

import (
	"container/list"
	"github.com/astaxie/beego"
	"github.com/gorilla/websocket"
	"github.com/Penun/swutil/models/sockets"
)

type Subscription struct {
	Archive []sockets.Event      // All the events from the archive.
	New     <-chan sockets.Event // New events coming in.
}

func newEvent(ep sockets.EventType, user string, wnd int64, str int64, ws_type string) sockets.Event {
	return sockets.Event{ep, sockets.Player{user, wnd, str, ws_type}}
}

func Join(user string, wound int64, strain int64, ws_type string, ws *websocket.Conn) {
	subscribe <- Subscriber{Name: user, Wound: wound, Strain: strain, Type: ws_type, Conn: ws}
}

func Leave(user string) {
	unsubscribe <- user
}

type Subscriber struct {
	Name string `json:"Name"`
    Wound int64 `json:"Wound"`
    Strain int64 `json:"Strain"`
    Type string `json:"Type"`
	Conn *websocket.Conn `json:"Conn"`// Only for WebSocket users; otherwise nil.
}

var (
	// Channel for new join users.
	subscribe = make(chan Subscriber, 10)
	// Channel for exit users.
	unsubscribe = make(chan string, 10)
	// Send events here to publish them.
	publish = make(chan sockets.Event, 10)
	subscribers = list.New()
)

// This function handles all incoming chan messages.
func tracker() {
	for {
		select {
		case sub := <-subscribe:
			if !isUserExist(subscribers, sub.Name) {
				subscribers.PushBack(sub) // Add user to the end of list.
				// Publish a JOIN event.
				publish <- newEvent(sockets.EVENT_JOIN, sub.Name, sub.Wound, sub.Strain, sub.Type)
				beego.Info("New user:", sub.Name, ";WebSocket:", sub.Conn != nil)
			} else {
				beego.Info("Old user:", sub.Name, ";WebSocket:", sub.Conn != nil)
			}
		case event := <-publish:
			broadcastWebSocket(event)
		case unsub := <-unsubscribe:
			for sub := subscribers.Front(); sub != nil; sub = sub.Next() {
				if sub.Value.(Subscriber).Name == unsub {
					subscribers.Remove(sub)
					// Clone connection.
					ws := sub.Value.(Subscriber).Conn
					if ws != nil {
						ws.Close()
						beego.Error("WebSocket closed:", unsub)
					}
					publish <- newEvent(sockets.EVENT_LEAVE, unsub, 0, 0, "") // Publish a LEAVE event.
					break
				}
			}
		}
	}
}

func init() {
	go tracker()
}

func isUserExist(subscribers *list.List, user string) bool {
	for sub := subscribers.Front(); sub != nil; sub = sub.Next() {
		if sub.Value.(Subscriber).Name == user {
			return true
		}
	}
	return false
}
