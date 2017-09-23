package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
)

type TalentsController struct {
	beego.Controller
}

type GetTalsResp struct {
    Success bool `json:"success"`
    Error string `json:"error"`
    Talents []models.Talent `json:"talents"`
}

type InsTalReq struct {
	Talent models.Talent `json:"talent"`
}

type InsTalResp struct{
	Success bool `json:"success"`
	Error string `json:"error"`
    Talent models.Talent `json:"talent"`
}

func (this *TalentsController) Get() {
    resp := GetTalsResp{Success: false, Error: ""}
	var t_spec []models.Talent
    t_spec = models.GetTalents()
	if len(t_spec) > 0{
		resp.Success = true
		resp.Talents = t_spec
	} else {
		resp.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *TalentsController) Add() {
	var insReq InsTalReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsTalResp{Success: false, Error: ""}
	if err == nil {
		sp_id := models.AddTalent(insReq.Talent)
        if sp_id > 0 {
	        insReq.Talent.Talent_id = sp_id
            resp.Talent = insReq.Talent
            resp.Success = true
        } else {
            resp.Error = "Failed to insert."
        }
	} else {
		resp.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}
