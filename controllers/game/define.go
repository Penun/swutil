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
    Result []LivePlayer `json:"result"`
}

type GetLogosResp struct {
    Success bool `json:"success"`
    Result []string `json:"result"`
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
	LivePlayer *LivePlayer `json:"live_player"`
}

type VerifyNameResp struct {
	Success bool `json:"success"`
	Player game.Player `json:"player"`
}

type CheckPlayerResp struct {
	Success bool `json:"success"`
	LivePlayer LivePlayer `json:"live_player"`
}

type ControllerReq struct {
	Type int `json:"type"`
	Data MultiMess `json:"data"`
}

type MultiMess struct {
    Players []string `json:"players"`
    Message string `json:"message"`
}

var (
	players = make([]LivePlayer, 0)
	master = false
	curInitInd = 0
	initStarted = false
    teamLogos = []string{"", "rebelLogo", "empireLogo", "jediOrder", "oldRepublic", "sithEmpire", "blackSun",
        "galacticSenateSeal", "lordRevan", "mandalorian", "bobaFettCrest", "hutt", "keresh", "firstOrder", "grievous",
        "mandClan", "mandMyst", "rebelsPheonix", "republicCredit", "revanchist", "seperatists", "vanaSages"}
)

const (
    _ = iota //0 Blank for unasigned teams
    T_REBEL //1
    T_EMPIRE //2
    T_JEDI //3
    T_OLDREP //4
    T_SITHEMP //5
    T_BLACKSUN //6
    T_GALSEN //7
    T_LORDREV //8
    T_MAND //9
    T_BOBAFETT //10
    T_HUTT //11
    T_KERESH //12
    T_FORDER //13
    T_GRIEV //14
    T_MANDCLAN // 15
    T_MANDMYST // 16
    T_REBPHEO // 17
    T_REPCRED // 18
    T_REVANCH // 19
    T_SEPER // 20
    T_VANASAGE // 21
)

type LivePlayer struct {
	Player *game.Player `json:"player"`
	Initiative float64 `json:"initiative"`
    CurWound int `json:"cur_wound"`
    CurStrain int `json:"cur_strain"`
    CurBoost int `json:"cur_boost"`
    CurSetback int `json:"cur_setback"`
    CurUpgrade int `json:"cur_upgrade"`
    CurUpDiff int `json:"cur_upDiff"`
    IsTurn bool `json:"isTurn"`
	Type string `json:"type"`
	Team int `json:"team"`
    DispStats bool `json:"disp_stats"`

}
