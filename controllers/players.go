package controllers

import (
	"github.com/Penun/swutil/models/game"
	"github.com/astaxie/beego"
    "encoding/json"
)

type PlayersController struct {
	beego.Controller
}

type GetCharsResp struct {
    Occ BaseResp `json:"occ"`
    Characters []game.Character `json:"players"`
}

type InsCharReq struct {
	Character game.Character `json:"player"`
	CharTalents []game.CharacterTalent `json:"play_talents"`
	CharForce []game.CharacterForce `json:"play_force"`
}

type InsCharResp struct{
	Occ BaseResp `json:"occ"`
    Character game.Character `json:"player"`
}

func (this *PlayersController) Get() {
    resp := GetCharsResp{Occ: BaseResp{Success: false, Error: ""}}
	var plays []game.Character
    plays = game.GetCharacters()
	if len(plays) > 0{
		resp.Occ.Success = true
		resp.Characters = plays
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *PlayersController) Add() {
	var insReq InsCharReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsCharResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		p_id := game.AddCharacter(insReq.Character)
        if p_id > 0 {
			insReq.Character.Id = p_id
            resp.Character = insReq.Character
			for i := 0; i < len(insReq.CharTalents); i++ {
				insReq.CharTalents[i].Character = &insReq.Character
				_ = game.AddCharTalent(insReq.CharTalents[i])
			}
			for i := 0; i < len(insReq.CharForce); i++ {
				insReq.CharForce[i].Character = &insReq.Character
				_ = game.AddCharForce(insReq.CharForce[i])
			}
            resp.Occ.Success = true
        } else {
            resp.Occ.Error = "Failed to insert."
        }
	} else {
		resp.Occ.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}
