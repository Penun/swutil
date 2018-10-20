package gamesocket

import "github.com/gorilla/websocket"

var (
	// Channel for new join users.
	subscribe = make(chan Subscriber, 10)
	curSubId = 0
	// Channel for exit users.
	unsubscribe = make(chan int, 10)
	// Send events here to publish them.
	Publish = make(chan Event, 10)
	subscribers = make([]Subscriber, 0)
)

type Subscription struct {
	Archive []Event      // All the events from the archive.
	New     <-chan Event // New events coming in.
}

type Subscriber struct {
	Id int `json:"id"`
	Name string `json:"name"`
    Watch bool `json:"watch"`
	Conn *websocket.Conn `json:"conn"`// Only for WebSocket users; otherwise nil.
}

type Event struct {
	Type int `json:"type"`
	Sender Sender `json:"sender"`
	Targets []int `json:"targets"` // Target Subscriber Ids
	Data string `json:"data"`
}

type Sender struct {
    Id int `json:"id"`
    Type string `json:"type"`
}

type SocketMessage struct {
	Type int `json:"type"`
	Player Sender `json:"player"`
	Data string `json:"data"`
}

type MultiMess struct {
    Targets []int `json:"targets"`
    Message string `json:"message"`
}
