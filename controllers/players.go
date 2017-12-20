package controllers

import (
	"github.com/Penun/swutil/models/sockets"
	"github.com/astaxie/beego"
    "encoding/json"
)

type PlayersController struct {
	beego.Controller
}

type GetPlaysResp struct {
    Occ BaseResp `json:"occ"`
    Players []sockets.Player `json:"players"`
}

type InsPlayReq struct {
	Player sockets.Player `json:"player"`
}

type InsPlayResp struct{
	Occ BaseResp `json:"occ"`
    Player sockets.Player `json:"player"`
}

func (this *PlayersController) Get() {
    resp := GetPlaysResp{Occ: BaseResp{Success: false, Error: ""}}
	var plays []sockets.Player
    plays = sockets.GetPlayers()
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
		p_id := sockets.AddPlayer(insReq.Player)
        if p_id > 0 {
	        insReq.Player.Id = p_id
            resp.Player = insReq.Player
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
