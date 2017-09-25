package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
	"encoding/json"
	"fmt"
)

type SpeciesController struct {
	beego.Controller
}

type GetResponse struct {
    Success bool `json:"success"`
    Error string `json:"error"`
    Result []models.Species `json:"result"`
}

type AttributeReq struct {
	Species_id int `json:"species_id"`
	Index int `json:"index"`
}

type AttributeResp struct {
	Success bool `json:"success"`
	Error string `json:"error"`
	Index int `json:"index"`
	Result []models.SpeAttribute `json:"result"`
}

type InsSpeReq struct {
	Species models.Species `json:"species"`
	Attributes []models.SpeAttribute `json:"attributes"`
}

type InsSpeResp struct{
	Success bool `json:"success"`
	Error string `json:"error"`
	Species models.Species `json:"species"`
	Attributes []models.SpeAttribute `json:"attributes"`
}

func (this *SpeciesController) Get() {
    resp := GetResponse{Success: false, Error: ""}
	var t_spec []models.Species
    t_spec = models.GetSpecies()
	if len(t_spec) > 0{
		resp.Success = true
		resp.Result = t_spec
	} else {
		resp.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *SpeciesController) Attributes() {
	var attreq AttributeReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &attreq)
	resp := AttributeResp{Success: false, Error: ""}
	if err == nil {
		resp.Index = attreq.Index
		t_spAtt := models.GetSpecAtt(int64(attreq.Species_id))
		if len(t_spAtt) > 0 {
			resp.Success = true
			resp.Result = t_spAtt
		} else {
			resp.Error = "Failed to find."
		}
	} else {
		fmt.Println(err)
		resp.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}


func (this *SpeciesController) Add() {
	var insReq InsSpeReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsSpeResp{Success: false, Error: ""}
	if err == nil {
		sp_id := models.AddSpecies(insReq.Species)
		insReq.Species.Id = sp_id
		resp.Species = insReq.Species
		for i := 0; i < len(insReq.Attributes); i++ {
			t_att := models.SpeAttribute{Species: &insReq.Species, Description: insReq.Attributes[i].Description}
			att_id := models.AddSpeAttribute(t_att)
			insReq.Attributes[i].Id = att_id
		}
		resp.Attributes = insReq.Attributes
		resp.Success = true
	} else {
		fmt.Println(err)
		resp.Error = "Failed Parse."
	}
	this.Data["json"] = resp
	this.ServeJSON()
}
