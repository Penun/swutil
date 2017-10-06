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
	beego.Router("/careers", &controllers.CareersController{})
	beego.Router("/careers/specializations", &controllers.CareersController{}, "post:Specializations")
	beego.Router("/skills", &controllers.SkillsController{})
	beego.Router("/specializations/talents", &controllers.SpecializationsController{}, "post:Talents")


	//beego.Router("/edit", &controllers.EditController{})
	//beego.Router("/species/add", &controllers.SpeciesController{}, "post:Add")
	//beego.Router("/specializations", &controllers.SpecializationsController{})
	//beego.Router("/specializations/add", &controllers.SpecializationsController{}, "post:Add")
	//beego.Router("/talents", &controllers.TalentsController{})
	//beego.Router("/talents/add", &controllers.TalentsController{}, "post:Add")
}
