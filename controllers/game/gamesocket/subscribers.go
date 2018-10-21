package gamesocket

import (
	"github.com/astaxie/beego"
	"github.com/gorilla/websocket"
)

// This function handles all incoming chan messages.
func tracker() {
	for {
		select {
		case sub := <-subscribe:
			if !IfUserExist(sub.Name) {
				subscribers = append(subscribers, sub) // Add user to the end of list.
				// Publish a JOIN event.
				beego.Info("New user:", sub.Name, ";WebSocket:", sub.Conn != nil)
			} else {
				beego.Info("Old user:", sub.Name, ";WebSocket:", sub.Conn != nil)
			}
		case event := <- Publish:
			broadcastWebSocket(event)
		case unsub := <-unsubscribe:
			subL := len(subscribers)
			for i := 0; i < subL; i++ {
				if subscribers[i].Id == unsub {
					ws := subscribers[i].Conn // Clone connection.
					sub_name := subscribers[i].Name
					if i == subL - 1 {
						subscribers = subscribers[:subL-1]
					} else {
						subscribers = append(subscribers[:i], subscribers[i+1:]...)
					}
					if ws != nil {
						ws.Close()
						beego.Error("WebSocket closed:", sub_name)
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

func NewEvent(ep int, user int, sub_type int, targets []int, data string, alert bool) Event {
	return Event{ep, Sender{Id: user, Type: sub_type}, targets, data, alert}
}

func Join(user string, sub_type int, ws *websocket.Conn) int {
	if sub_type == SUB_MASTER {
		subscribe <- Subscriber{Id: SUB_MASTER, Name: user, Type: sub_type, Conn: ws}
		return SUB_MASTER
	} else {
		curSubId++
		subscribe <- Subscriber{Id: curSubId, Name: user, Type: sub_type, Conn: ws}
		return curSubId
	}
}

func Leave(user int) {
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
