package models

import (
    "github.com/astaxie/beego/orm"
)

func GetVehicles() []Vehicle{
    o := orm.NewOrm()
    var vehis []Vehicle
    o.QueryTable("vehicle").OrderBy("type", "model").All(&vehis)
    if len(vehis) > 0 {
        return vehis
    } else {
        return []Vehicle{}
    }
}

func AddVehicle(vehi Vehicle) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&vehi)
	if err == nil {
		return id
	} else {
		return 0
	}
}
