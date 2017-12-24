package controllers

import (
	"github.com/Penun/swutil/models/game"
	"github.com/astaxie/beego"
    "encoding/json"
)

type PlayersController struct {
	beego.Controller
}

type GetPlaysResp struct {
    Occ BaseResp `json:"occ"`
    Players []game.Player `json:"players"`
}

type InsPlayReq struct {
	Player game.Player `json:"player"`
	PlayTalents []game.PlayerTalent `json:"play_talents"`
	PlayForce []game.PlayerForce `json:"play_force"`
}

type InsPlayResp struct{
	Occ BaseResp `json:"occ"`
    Player game.Player `json:"player"`
}

func (this *PlayersController) Get() {
    resp := GetPlaysResp{Occ: BaseResp{Success: false, Error: ""}}
	var plays []game.Player
    plays = game.GetPlayers()
	if len(plays) > 0{
		resp.Occ.Success = true
		resp.Players = plays
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *PlayersController) Add() {
	var insReq InsPlayReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsPlayResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		p_id := game.AddPlayer(insReq.Player)
        if p_id > 0 {
			insReq.Player.Id = p_id
            resp.Player = insReq.Player
			for i := 0; i < len(insReq.PlayTalents); i++ {
				insReq.PlayTalents[i].Player = &insReq.Player
				_ = game.AddPlayTalent(insReq.PlayTalents[i])
			}
			for i := 0; i < len(insReq.PlayForce); i++ {
				insReq.PlayForce[i].Player = &insReq.Player
				_ = game.AddPlayForce(insReq.PlayForce[i])
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
