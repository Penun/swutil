package models

import (
    "github.com/astaxie/beego/orm"
)

func GetGear() []Gear{
    o := orm.NewOrm()
    var gear []Gear
    o.QueryTable("gear").OrderBy("type", "item").All(&gear)
    if len(gear) > 0 {
        return gear
    } else {
        return []Gear{}
    }
}

func AddGear(gear Gear) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&gear)
	if err == nil {
		return id
	} else {
		return 0
	}
}
