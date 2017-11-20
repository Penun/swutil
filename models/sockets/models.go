package sockets

// import (
// 	"container/list"
// )

type EventType int

const (
	EVENT_JOIN = iota //0
	EVENT_LEAVE //1
	EVENT_NOTE //2
	EVENT_WOUND //3
	EVENT_STRAIN //4
	EVENT_INIT //5
	EVENT_INIT_D //6
	EVENT_INIT_S //7
	EVENT_INIT_T //8
)

type Event struct {
	Type EventType `json:"type"`
	Sender Sender `json:"sender"`
	Targets []string `json:"targets"`
	Data string `json:"data"`
}

type Player struct {
    Name string `json:"name"`
	Wound int `json:"wound"`
    Strain int `json:"strain"`
	Initiative float64 `json:"initiative"`
}

type Sender struct {
	Name string `json:"name"`
	Type string `json:"type"`
}
