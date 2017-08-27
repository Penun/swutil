package routers

import (
	"github.com/Penun/swutil/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
	beego.Router("/species", &controllers.SpeciesController{})
	beego.Router("/species/attributes", &controllers.SpeciesController{}, "post:Attributes")
}
