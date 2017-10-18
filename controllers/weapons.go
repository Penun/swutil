package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
	"github.com/astaxie/beego/orm"
)

type WeaponsController struct {
	beego.Controller
}

type GetWeapResp struct {
    Occ BaseResp `json:"occ"`
    Weapons []models.Weapon `json:"weapons"`
}

type GetTypeResp struct {
    Occ BaseResp `json:"occ"`
    Weapons []string `json:"weapons"`
}

type GetSuTyReq struct {
	Type string `json:"type"`
	Index int `json:"index"`
}

type GetSuTyResp struct {
    Occ BaseResp `json:"occ"`
    SubTypes []orm.Params `json:"sub_types"`
	Index int `json:"index"`
}

type GetBySuReq struct {
	SubType string `json:"sub_type"`
	Index int `json:"index"`
}

type GetBySuResp struct {
    Occ BaseResp `json:"occ"`
    Weapons []models.Weapon `json:"weapons"`
	Index int `json:"index"`
}

type InsWeapReq struct {
	Weapon models.Weapon `json:"weapon"`
}

type InsWeapResp struct{
	Occ BaseResp `json:"occ"`
    Weapon models.Weapon `json:"weapon"`
}

func (this *WeaponsController) Get() {
    resp := GetWeapResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Weapon
    t_spec = models.GetWeapons()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Weapons = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *WeaponsController) Types() {
	resp := GetTypeResp{Occ: BaseResp{Success: true, Error: ""}}
	resp.Weapons = make([]string, 4)
	resp.Weapons[0] = "Ranged"
	resp.Weapons[1] = "Melee"
	resp.Weapons[2] = "Lightsaber"
	resp.Weapons[3] = "Micro-Rockets"
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *WeaponsController) SubTypes() {
	var getReq GetSuTyReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &getReq)
	resp := GetSuTyResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		subs := models.GetWeaponSubTypesByType(getReq.Type)
        if len(subs) > 0 {
			resp.Index = getReq.Index
            resp.SubTypes = subs
            resp.Occ.Success = true
        } else {
            resp.Occ.Error = "Failed to find."
        }
	} else {
		resp.Occ.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *WeaponsController) BySub() {
	var getReq GetBySuReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &getReq)
	resp := GetBySuResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		weaps := models.GetWeaponsBySub(getReq.SubType)
        if len(weaps) > 0 {
			resp.Index = getReq.Index
            resp.Weapons = weaps
            resp.Occ.Success = true
        } else {
            resp.Occ.Error = "Failed to find."
        }
	} else {
		resp.Occ.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}

func (this *WeaponsController) Add() {
	var insReq InsWeapReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsWeapResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddWeapon(insReq.Weapon)
        if sp_id > 0 {
	        insReq.Weapon.Id = sp_id
            resp.Weapon = insReq.Weapon
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
