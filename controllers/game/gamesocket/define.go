package gamesocket

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
	EVENT_INIT_E //9
    EVENT_BOOST //10
    EVENT_SETBACK //11
    EVENT_UPGRADE //12
    EVENT_UPDIFF //13
    EVENT_TEAM //14
)

type Event struct {
	Type int `json:"type"`
	Sender Sender `json:"sender"`
	Targets []string `json:"targets"`
	Data string `json:"data"`
}

type Sender struct {
    Name string `json:"name"`
    Type string `json:"type"`
}
