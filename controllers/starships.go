package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
)

type StarshipsController struct {
	beego.Controller
}

type GetStarResp struct {
    Occ BaseResp `json:"occ"`
    Starships []models.Starship `json:"starships"`
}

type InsStarReq struct {
	Starship models.Starship `json:"starship"`
}

type InsStarResp struct{
	Occ BaseResp `json:"occ"`
    Starship models.Starship `json:"starship"`
}

func (this *StarshipsController) Get() {
    resp := GetStarResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Starship
    t_spec = models.GetStarships()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Starships = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *StarshipsController) Add() {
	var insReq InsStarReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsStarResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddStarship(insReq.Starship)
        if sp_id > 0 {
	        insReq.Starship.Id = sp_id
            resp.Starship = insReq.Starship
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
