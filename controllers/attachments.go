package controllers

import (
	"github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    "encoding/json"
)

type AttachmentsController struct {
	beego.Controller
}

type GetAttaResp struct {
    Occ BaseResp `json:"occ"`
    Attachment []models.Attachment `json:"attachments"`
}

type InsAttaReq struct {
	Attachment models.Attachment `json:"attachment"`
}

type InsAttaResp struct{
	Occ BaseResp `json:"occ"`
    Attachment models.Attachment `json:"attachment"`
}

func (this *AttachmentsController) Get() {
    resp := GetAttaResp{Occ: BaseResp{Success: false, Error: ""}}
	var t_spec []models.Attachment
    t_spec = models.GetAttachment()
	if len(t_spec) > 0{
		resp.Occ.Success = true
		resp.Attachment = t_spec
	} else {
		resp.Occ.Error = "None found."
	}
    this.Data["json"] = resp
    this.ServeJSON()
}

func (this *AttachmentsController) Add() {
	var insReq InsAttaReq
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &insReq)
	resp := InsAttaResp{Occ: BaseResp{Success: false, Error: ""}}
	if err == nil {
		sp_id := models.AddAttachment(insReq.Attachment)
        if sp_id > 0 {
	        insReq.Attachment.Id = sp_id
            resp.Attachment = insReq.Attachment
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
