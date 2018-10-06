package game

import (
	"encoding/json"
	"github.com/Penun/swutil/models/game"
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
