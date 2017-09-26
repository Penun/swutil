package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
	//"fmt"
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
	Careers []int64 `json:"careers"`
	Skills []int64 `json:"skills"`
	SpecTalents []models.SpecTalent `json:"talents"`
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

 func (this *SpecializationsController) Add() {
	var insReq InsSpecReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsSpecResp{Success: false, Error: ""}
	if err == nil {
		sp_id := models.AddSpecialization(insReq.Specialization)
        if sp_id > 0 {
			insReq.Specialization.Id = sp_id
			for i := 0; i < len(insReq.Careers); i++ {
				caSp := new(models.CareerSpec)
				caSp.Specialization = &insReq.Specialization
				caSp.Career = new(models.Career)
				caSp.Career.Id = insReq.Careers[i]
				_ = models.AddCareerSpec(*caSp)
			}
	        for i := 0; i < len(insReq.Skills); i++ {
				spSk := new(models.SpecSkill)
				spSk.Specialization = &insReq.Specialization
				spSk.Skill = new(models.Skill)
				spSk.Skill.Id = insReq.Skills[i]
				_ = models.AddSpecSkill(*spSk)
			}
			for i := 0; i < len(insReq.SpecTalents); i++ {
				insReq.SpecTalents[i].Specialization = &insReq.Specialization
				_ = models.AddSpecTalent(insReq.SpecTalents[i])
			}
            resp.Specialization = insReq.Specialization
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
