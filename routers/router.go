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
	beego.Router("/careers/skills", &controllers.CareersController{}, "post:Skills")
	beego.Router("/skills", &controllers.SkillsController{})
	beego.Router("/specializations/talents", &controllers.SpecializationsController{}, "post:Talents")
	beego.Router("/specializations/skills", &controllers.SpecializationsController{}, "post:Skills")
	beego.Router("/weapons/types", &controllers.WeaponsController{}, "get:Types")
	beego.Router("/weapons/sub_types", &controllers.WeaponsController{}, "post:SubTypes")
	beego.Router("/weapons/by_sub", &controllers.WeaponsController{}, "Post:BySub")
	beego.Router("/armor", &controllers.ArmorController{})

	beego.Router("/weapons", &controllers.WeaponsController{})
	beego.Router("/weapons/add", &controllers.WeaponsController{}, "post:Add")
	beego.Router("/armor/add", &controllers.ArmorController{}, "post:Add")
	beego.Router("/gear", &controllers.GearController{})
	beego.Router("/gear/add", &controllers.GearController{}, "post:Add")
	beego.Router("/attachments", &controllers.AttachmentsController{})
	beego.Router("/attachments/add", &controllers.AttachmentsController{}, "post:Add")
	beego.Router("/droids", &controllers.DroidsController{})
	beego.Router("/droids/add", &controllers.DroidsController{}, "post:Add")
	beego.Router("/vehicles", &controllers.VehiclesController{})
	beego.Router("/vehicles/add", &controllers.VehiclesController{}, "post:Add")
	beego.Router("/starships", &controllers.StarshipsController{})
	beego.Router("/starships/add", &controllers.StarshipsController{}, "post:Add")

	beego.Router("/edit", &controllers.EditController{})
	//beego.Router("/species/add", &controllers.SpeciesController{}, "post:Add")
	//beego.Router("/specializations", &controllers.SpecializationsController{})
	//beego.Router("/specializations/add", &controllers.SpecializationsController{}, "post:Add")
	beego.Router("/talents", &controllers.TalentsController{})
	//beego.Router("/talents/add", &controllers.TalentsController{}, "post:Add")
}
