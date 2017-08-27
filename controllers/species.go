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
	Result []models.SpecAttribute `json:"result"`
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
