package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    //"encoding/json"
)

type ForceController struct {
	beego.Controller
}

type GetForceResp struct {
    Occ BaseResp `json:"occ"`
    ForceP []models.Force `json:"forceP"`
}

func (this *ForceController) Get() {
    resp := GetForceResp{Occ: BaseResp{Success: false, Error: ""}}
	var force []models.Force
    force = models.GetForce()
	if len(force) > 0{
		resp.Occ.Success = true
		resp.ForceP = force
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}
