package routers

import (
	"github.com/Penun/swutil/controllers"
	"github.com/astaxie/beego"
)

func init() {
    beego.Router("/", &controllers.MainController{})
	beego.Router("/species", &controllers.SpeciesController{})
	beego.Router("/species/attributes", &controllers.SpeciesController{}, "post:Attributes")
	beego.Router("/books", &controllers.MainController{}, "get:Books")
	beego.Router("/talents", &controllers.TalentsController{})
	beego.Router("/talents/add", &controllers.TalentsController{}, "post:Add")
	beego.Router("/careers", &controllers.CareersController{})
	beego.Router("/skills", &controllers.SkillsController{})
	beego.Router("/specializations", &controllers.SpecializationsController{})

	beego.Router("/edit", &controllers.EditController{})
	beego.Router("/species/add", &controllers.SpeciesController{}, "post:Add")
}
