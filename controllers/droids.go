package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
)

type DroidsController struct {
	beego.Controller
}

type GetDroiResp struct {
    Occ BaseResp `json:"occ"`
    Droids []models.Droid `json:"droids"`
}

type InsDroidReq struct {
	Droid models.Droid `json:"droid"`
	Skills []models.DroidSkill `json:"skills"`
	Talents []models.DroidTalent `json:"talents"`
}

type InsDroidResp struct{
	Occ BaseResp `json:"occ"`
    Droid models.Droid `json:"droid"`
}

func (this *DroidsController) Get() {
    resp := GetDroiResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Droid
    t_spec = models.GetDroids()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Droids = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *DroidsController) Add() {
	var insReq InsDroidReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsDroidResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddDroid(insReq.Droid)
        if sp_id > 0 {
	        insReq.Droid.Id = sp_id
            resp.Droid = insReq.Droid
			for i := 0; i < len(insReq.Skills); i++ {
				insReq.Skills[i].Droid = new(models.Droid)
				insReq.Skills[i].Droid.Id = sp_id
				_ = models.AddDroidSkill(insReq.Skills[i])
			}
			for i := 0; i < len(insReq.Talents); i++ {
				insReq.Talents[i].Droid = new(models.Droid)
				insReq.Talents[i].Droid.Id = sp_id
				_ = models.AddDroidTalent(insReq.Talents[i])
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
