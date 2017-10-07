package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
	"encoding/json"
)

type CareersController struct {
	beego.Controller
}

type GetCarsResp struct {
    Occ BaseResp `json:"occ"`
    Careers []models.Career `json:"careers"`
}

type GetCSReq struct {
	Career_id int `json:"career_id"`
	Index int `json:"index"`
}

type GetCSKResp struct {
	Occ BaseResp `json:"occ"`
	Result []models.CareerSkill `json:"result"`
	Index int `json:"index"`
}

type GetCSResp struct {
	Occ BaseResp `json:"occ"`
	Result []models.Specialization `json:"result"`
	Index int `json:"index"`
}

func (this *CareersController) Get() {
    resp := GetCarsResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_cars []models.Career
    t_cars = models.GetCareers()
	if len(t_cars) > 0{
		resp.Occ.Success = true
		resp.Careers = t_cars
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *CareersController) Specializations() {
	var req GetCSReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &req)
	resp := GetCSResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		resp.Index = req.Index
		cSpecs := models.GetSpecialByCareer(int64(req.Career_id))
		if cSLen := len(cSpecs); cSLen > 0 {
			resSpec := make([]models.Specialization, cSLen)
			for i := 0; i < cSLen; i++ {
				resSpec[i] = *cSpecs[i].Specialization
			}
			resp.Occ.Success = true
			resp.Result = resSpec
		} else {
			resp.Occ.Error = "Failed to find."
		}
	} else {
		resp.Occ.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *CareersController) Skills() {
	var req GetCSReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &req)
	resp := GetCSKResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		resp.Index = req.Index
		cSkills := models.GetSkillsByCareer(int64(req.Career_id))
		if len(cSkills) > 0 {
			resp.Occ.Success = true
			resp.Result = cSkills
		} else {
			resp.Occ.Error = "Failed to find."
		}
	} else {
		resp.Occ.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}
