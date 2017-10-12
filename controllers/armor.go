package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
)

type ArmorController struct {
	beego.Controller
}

type GetArmResp struct {
    Occ BaseResp `json:"occ"`
    Armor []models.Armor `json:"armor"`
}

type InsArmReq struct {
	Armor models.Armor `json:"armor"`
}

type InsArmResp struct{
	Occ BaseResp `json:"occ"`
    Armor models.Armor `json:"armor"`
}

func (this *ArmorController) Get() {
    resp := GetArmResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Armor
    t_spec = models.GetArmor()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Armor = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *ArmorController) Add() {
	var insReq InsArmReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsArmResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddArmor(insReq.Armor)
        if sp_id > 0 {
	        insReq.Armor.Id = sp_id
            resp.Armor = insReq.Armor
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
