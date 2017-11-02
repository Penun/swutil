package sockets

// import (
// 	"container/list"
// )

type EventType int

const (
	EVENT_JOIN = iota
	EVENT_LEAVE
	EVENT_INCREASE
	EVENT_DECREASE
)

type Event struct {
	Type EventType // JOIN, LEAVE, MESSAGE
	Player Player
}

type Player struct {
    Name string
	Wound int64
    Strain int64
    Type string
}

// const archiveSize = 20
//
// // Event archives.
// var archive = list.New()
//
// // NewArchive saves new event to archive list.
// func NewArchive(event Event) {
// 	if archive.Len() >= archiveSize {
// 		archive.Remove(archive.Front())
// 	}
// 	archive.PushBack(event)
// }
//
// // GetEvents returns all events after lastReceived.
// func GetEvents(lastReceived int) []Event {
// 	events := make([]Event, 0, archive.Len())
// 	for event := archive.Front(); event != nil; event = event.Next() {
// 		e := event.Value.(Event)
// 		if e.Timestamp > int(lastReceived) {
// 			events = append(events, e)
// 		}
// 	}
// 	return events
// }
