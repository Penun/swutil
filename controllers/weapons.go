package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
)

type WeaponsController struct {
	beego.Controller
}

type GetWeapResp struct {
    Occ BaseResp `json:"occ"`
    Weapons []models.Weapon `json:"weapons"`
}

type InsWeapReq struct {
	Weapon models.Weapon `json:"weapon"`
}

type InsWeapResp struct{
	Occ BaseResp `json:"occ"`
    Weapon models.Weapon `json:"weapon"`
}

func (this *WeaponsController) Get() {
    resp := GetWeapResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Weapon
    t_spec = models.GetWeapons()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Weapons = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *WeaponsController) Add() {
	var insReq InsWeapReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsWeapResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddWeapon(insReq.Weapon)
        if sp_id > 0 {
	        insReq.Weapon.Id = sp_id
            resp.Weapon = insReq.Weapon
            resp.Occ.Success = true
        } else {
            resp.Occ.Error = "Failed to insert."
        }
	} else {
		resp.Occ.Error = "Failed Parse." + err.Error()
	}
	this.Data["json"] = resp
	this.ServeJSON()
}
