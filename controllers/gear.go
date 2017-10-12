package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
)

type GearController struct {
	beego.Controller
}

type GetGearResp struct {
    Occ BaseResp `json:"occ"`
    Gear []models.Gear `json:"gear"`
}

type InsGearReq struct {
	Gear models.Gear `json:"gear"`
}

type InsGearResp struct{
	Occ BaseResp `json:"occ"`
    Gear models.Gear `json:"gear"`
}

func (this *GearController) Get() {
    resp := GetGearResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Gear
    t_spec = models.GetGear()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Gear = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *GearController) Add() {
	var insReq InsGearReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsGearResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddGear(insReq.Gear)
        if sp_id > 0 {
	        insReq.Gear.Id = sp_id
            resp.Gear = insReq.Gear
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
