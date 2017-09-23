package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
)

type SkillsController struct {
	beego.Controller
}

type GetSklsResp struct {
    Success bool `json:"success"`
    Error string `json:"error"`
    Skills []models.Skill `json:"skills"`
}

func (this *SkillsController) Get() {
    resp := GetSklsResp{Success: false, Error: ""}
	var t_skil []models.Skill
    t_skil = models.GetSkills()
	if len(t_skil) > 0{
		resp.Success = true
		resp.Skills = t_skil
	} else {
		resp.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}
