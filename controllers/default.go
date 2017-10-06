package controllers

import (
	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

type BaseResp struct {
	Success bool `json:"success"`
	Error string `json:"error"`
}

func (c *MainController) Get() {
	c.TplName = "index.tpl"
}

func (this *MainController) Books() {
	this.TplName = "books.tpl"
}
