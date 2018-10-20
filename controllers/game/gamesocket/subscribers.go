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
				Publish <- NewEvent(0, sub.Id, sub.Watch, nil, "")
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

func NewEvent(ep int, user int, watch bool, targets []int, data string) Event {
	retEve := Event{ep, Sender{Id: user}, targets, data}
	if user == 0 {
		retEve.Sender.Type = "master"
	} else if watch {
		retEve.Sender.Type = "watch"
	} else {
		retEve.Sender.Type = "play"
	}
	return retEve
}

func Join(user string, watch bool, ws *websocket.Conn, master bool) int {
	if master {
		subscribe <- Subscriber{Id: 0, Name: user, Watch: watch, Conn: ws}
		return 0
	} else {
		curSubId++
		subscribe <- Subscriber{Id: curSubId, Name: user, Watch: watch, Conn: ws}
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
