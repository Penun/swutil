package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    //"encoding/json"
)

type SpecializationsController struct {
	beego.Controller
}

type GetSpecsResp struct {
    Success bool `json:"success"`
    Error string `json:"error"`
    Specializations []models.Specialization `json:"specializations"`
}

type InsSpecReq struct {
	Specialization models.Specialization `json:"specialization"`
}

type InsSpecResp struct{
	Success bool `json:"success"`
	Error string `json:"error"`
    Specialization models.Specialization `json:"specialization"`
}

func (this *SpecializationsController) Get() {
    resp := GetSpecsResp{Success: false, Error: ""}
	var t_spec []models.Specialization
    t_spec = models.GetSpecializations()
	if len(t_spec) > 0{
		resp.Success = true
		resp.Specializations = t_spec
	} else {
		resp.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}
