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
    Occ BaseResp `json:"occ"`
    Specializations []models.Specialization `json:"specializations"`
}

type GetSpTaReq struct {
	Specialization_id int `json:"specialization_id"`
	Index int `json:"index"`
}

type GetSpTaResp struct {
	Occ BaseResp `json:"occ"`
	Result []models.SpecTalent `json:"result"`
	Index int `json:"index"`
}

type GetSpSkResp struct {
	Occ BaseResp `json:"occ"`
	Result []models.SpecSkill `json:"result"`
	Index int `json:"index"`
}

type InsSpecReq struct {
	Specialization models.Specialization `json:"specialization"`
	Careers []int64 `json:"careers"`
	Skills []int64 `json:"skills"`
	SpecTalents []models.SpecTalent `json:"talents"`
}

type InsSpecResp struct{
	Occ BaseResp `json:"occ"`
    Specialization models.Specialization `json:"specialization"`
}

func (this *SpecializationsController) Get() {
    resp := GetSpecsResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Specialization
    t_spec = models.GetSpecializations()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Specializations = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *SpecializationsController) Talents() {
	var req GetSpTaReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &req)
	resp := GetSpTaResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		resp.Index = req.Index
		cSpecs := models.GetTalentsBySpecial(int64(req.Specialization_id))
		if len(cSpecs) > 0 {
			resp.Occ.Success = true
			resp.Result = cSpecs
		} else {
			resp.Occ.Error = "Failed to find."
		}
	} else {
		resp.Occ.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *SpecializationsController) Skills() {
	var req GetSpTaReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &req)
	resp := GetSpSkResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		resp.Index = req.Index
		cSpecs := models.GetSkillsBySpecial(int64(req.Specialization_id))
		if len(cSpecs) > 0 {
			resp.Occ.Success = true
			resp.Result = cSpecs
		} else {
			resp.Occ.Error = "Failed to find."
		}
	} else {
		resp.Occ.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *SpecializationsController) Add() {
	var insReq InsSpecReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsSpecResp{Occ: BaseResp{Success: false, Error: ""}}
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
