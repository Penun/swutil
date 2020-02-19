package game

import (
    "github.com/astaxie/beego"
    "github.com/Penun/swutil/models/game"
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

var (
	players = make([]LivePlayer, 0)
	master = false
	curInitInd = 0
    curPlayId = 0
	initStarted = false
    teamLogos = []string{"", "rebelLogo", "empireLogo", "jediOrder", "oldRepublic", "sithEmpire", "blackSun",
        "galacticSenateSeal", "lordRevan", "mandalorian", "bobaFettCrest", "hutt", "keresh", "firstOrder", "grievous",
        "mandClan", "mandMyst", "rebelsPheonix", "republicCredit", "revanchist", "seperatists", "vanaSages"}
    playCharSubs = make(map[int]int)
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

type FindCharacterReq struct {
	Name string `json:"name"`
}

type IdCharacterReq struct {
    Id int `json:"id"`
}

type FindCharacterResp struct {
	Success bool `json:"success"`
	Characters []game.Character `json:"characters"`
}

type GetPlayerResp struct {
	Success bool `json:"success"`
	LivePlayer *LivePlayer `json:"live_player"`
}

type VerifyNameResp struct {
	Success bool `json:"success"`
	Character game.Character `json:"character"`
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
    Players []int `json:"targets"`
    Message string `json:"message"`
}

type LivePlayer struct {
    subId int `json:"sub_id"`
    Id int `json:"id"`
	Character *game.Character `json:"character"`
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
