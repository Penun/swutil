package game

import (
    "github.com/astaxie/beego"
    "github.com/Penun/swutil/models/game"
)

type GameStatusController struct {
	beego.Controller
}

type GetSubsResp struct {
	Success bool `json:"success"`
    Result []game.LivePlayer `json:"result"`
}

type GetStatusResp struct {
	Success bool `json:"success"`
	StartInit bool `json:"start_init"`
	CurInitInd int `json:"cur_init_ind"`
}

type FindPlayerReq struct {
	Name string `json:"name"`
}

type FindPlayerResp struct {
	Success bool `json:"success"`
	Players []game.Player `json:"players"`
}

type GetPlayerResp struct {
	Success bool `json:"success"`
	LivePlayer *game.LivePlayer `json:"live_player"`
}

type VerifyNameResp struct {
	Success bool `json:"success"`
	Player game.Player `json:"player"`
}

type CheckPlayerResp struct {
	Success bool `json:"success"`
	LivePlayer game.LivePlayer `json:"live_player"`
}

type ControllerReq struct {
	Type string `json:"type"`
	Data MultiMess `json:"data"`
}

type MultiMess struct {
    Players []string `json:"players"`
    Message string `json:"message"`
}

var (
	players = make([]game.LivePlayer, 0)
	master = false
	curInitInd = 0
	initStarted = false
)
