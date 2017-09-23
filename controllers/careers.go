package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
)

type CareersController struct {
	beego.Controller
}

type GetCarsResp struct {
    Success bool `json:"success"`
    Error string `json:"error"`
    Careers []models.Career `json:"careers"`
}

func (this *CareersController) Get() {
    resp := GetCarsResp{Success: false, Error: ""}
	var t_cars []models.Career
    t_cars = models.GetCareers()
	if len(t_cars) > 0{
		resp.Success = true
		resp.Careers = t_cars
	} else {
		resp.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}
