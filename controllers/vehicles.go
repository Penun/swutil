package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
)

type VehiclesController struct {
	beego.Controller
}

type GetVehiResp struct {
    Occ BaseResp `json:"occ"`
    Vehicles []models.Vehicle `json:"vehicles"`
}

type InsVehiReq struct {
	Vehicle models.Vehicle `json:"vehicle"`
}

type InsVehiResp struct{
	Occ BaseResp `json:"occ"`
    Vehicle models.Vehicle `json:"vehicle"`
}

func (this *VehiclesController) Get() {
    resp := GetVehiResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Vehicle
    t_spec = models.GetVehicles()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Vehicles = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *VehiclesController) Add() {
	var insReq InsVehiReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsVehiResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddVehicle(insReq.Vehicle)
        if sp_id > 0 {
	        insReq.Vehicle.Id = sp_id
            resp.Vehicle = insReq.Vehicle
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
