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
    Occ BaseResp `json:"occ"`
    Talents []models.Talent `json:"talents"`
}

type InsTalReq struct {
	Talent models.Talent `json:"talent"`
}

type InsTalResp struct{
	Occ BaseResp `json:"occ"`
    Talent models.Talent `json:"talent"`
}

func (this *TalentsController) Get() {
    resp := GetTalsResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Talent
    t_spec = models.GetTalents()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Talents = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *TalentsController) Add() {
	var insReq InsTalReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsTalResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddTalent(insReq.Talent)
        if sp_id > 0 {
	        insReq.Talent.Id = sp_id
            resp.Talent = insReq.Talent
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
