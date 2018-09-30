package game

import (
	"encoding/json"
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

var (
	players = make([]game.LivePlayer, 0)
	master = false
	curInitInd = 0
	initStarted = false
)

func (this *GameStatusController) Get() {
	this.TplName = "game/index.tpl"
}

func (this *GameStatusController) Watch() {
	this.TplName = "game/watch.tpl"
}

func (this *GameStatusController) Master() {
	this.TplName = "game/master.tpl"
}

func (this *GameStatusController) Check() {
	resp := CheckPlayerResp{Success: false}
	if findPlay := this.GetSession("player"); findPlay != nil {
		resp.LivePlayer = GetPlayerName(findPlay.(string))
		if (resp.LivePlayer != game.LivePlayer{}){
			resp.Success = true
		} else {
			this.DelSession("player")
		}
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *GameStatusController) Subs() {
	resp := GetSubsResp{Success: false}
	typ := this.GetString("type")
	if typ == "play" {
		var playOnl []game.LivePlayer
		for i := 0; i < len(players); i++ {
			if players[i].Type == "PC" {
				playOnl = append(playOnl, players[i])
			}
		}
		if master {
			tempPlay := game.Player{Name: "DM"}
			tempLPlay := game.LivePlayer{Player: &tempPlay}
			playOnl = append(playOnl, tempLPlay)
		}
		resp.Result = playOnl
		resp.Success = true
	} else {
		if len(players) > 0 {
			resp.Result = players
			resp.Success = true
		}
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *GameStatusController) GameStatus() {
	resp := GetStatusResp{true, initStarted, curInitInd}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *GameStatusController) FindPlayer() {
    var findReq FindPlayerReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &findReq)
	resp := FindPlayerResp{Success: false}
	if err == nil {
		playSugs := game.GetPlayerLike(findReq.Name)
        if len(playSugs) > 0 {
            resp.Players = playSugs
            resp.Success = true
        }
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *GameStatusController) VerifyName() {
	var findReq FindPlayerReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &findReq)
	resp := VerifyNameResp{Success: false}
	if err == nil {
		player := game.GetPlayerName(findReq.Name)
        if (player != game.Player{}) {
            resp.Player = player
            resp.Success = true
        }
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *GameStatusController) GetPlayer() {
    var getReq FindPlayerReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &getReq)
	resp := GetPlayerResp{Success: false}
	if err == nil {
		for _, play := range players {
			if play.Player.Name == getReq.Name {
				resp.LivePlayer = &play
				resp.Success = true
				break
			}
        }
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func GetPlayerName(playName string) game.LivePlayer {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				return players[i]
			}
		}
	}
	return game.LivePlayer{}
}

func WoundPlayer(playName string, wound int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				players[i].CurWound += wound
				break
			}
		}
	}
}

func StrainPlayer(playName string, strain int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				players[i].CurStrain += strain
				break
			}
		}
	}
}

func InitPlayer(playName string, init float64) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				players[i].Initiative = init
				break
			}
		}
	}
}

func DeletePlayer(play game.LivePlayer) {
	if play != (game.LivePlayer{}) {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == play.Player.Name {
				RemovePlayer(i)
				break
			}
		}
	}
}

func DeletePlayerName(playName string) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				RemovePlayer(i)
				break
			}
		}
	}
}

func FindInSlice(targets []string, sub Subscriber) bool {
	for j := 0; j < len(targets); j++ {
		if targets[j] == sub.Name {
			return true
		}
	}
	return false
}

func RemovePlayer(i int) {
	setTurn := players[i].IsTurn
	playLen := len(players)
	if i == playLen - 1 {
		players = players[:playLen-1]
	} else {
		players = append(players[:i], players[i+1:]...)
	}
	playLen--
	if curInitInd == i {
		if playLen == 0 {
			curInitInd = 0
		} else if i == playLen {
			curInitInd--
		}
	}
	if setTurn && playLen > 0 {
		players[curInitInd].IsTurn = true
	}
}

func SortPlayerInit() {
	for  i := 0; i < len(players); i++ {
		minInd := i
		for j := i + 1; j < len(players); j++ {
			if players[j].Initiative > players[minInd].Initiative {
				minInd = j
			}
		}
		if minInd != i {
			swap := players[i]
			players[i] = players[minInd]
			players[minInd] = swap
		}
	}
	if initStarted {
		for ind, play := range players {
			if play.IsTurn {
				curInitInd = ind
				break
			}
		}
	}
}

func FindNextInitInd(incCur bool, reverse bool) {
	if !incCur {
		if !reverse {
			MoveCurIndFor()
		} else {
			MoveCurIndBack()
		}
	}
	for i := 0; i < len(players); i++ {
		if players[curInitInd].Initiative > 0 {
			return
		}
		if !reverse {
			MoveCurIndFor()
		} else {
			MoveCurIndBack()
		}
	}
}

func MoveCurIndFor() {
	if curInitInd == len(players) - 1 {
		curInitInd = 0
	} else {
		curInitInd++
	}
}

func MoveCurIndBack() {
	if curInitInd == 0 {
		curInitInd = len(players) - 1
	} else {
		curInitInd--
	}
}
