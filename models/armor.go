package models

import (
    "github.com/astaxie/beego/orm"
)

func GetArmor() []Armor{
    o := orm.NewOrm()
    var armor []Armor
    o.QueryTable("armor").OrderBy("type").All(&armor)
    if len(armor) > 0 {
        return armor
    } else {
        return []Armor{}
    }
}

func AddArmor(arm Armor) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&arm)
	if err == nil {
		return id
	} else {
		return 0
	}
}
