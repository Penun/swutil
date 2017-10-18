package models

import (
    "github.com/astaxie/beego/orm"
)

func GetWeapons() []Weapon{
    o := orm.NewOrm()
    var weapons []Weapon
    o.QueryTable("weapon").OrderBy("type", "sub_type", "name").All(&weapons)
    if len(weapons) > 0 {
        return weapons
    } else {
        return []Weapon{}
    }
}

func GetWeaponSubTypesByType(typ string) []orm.Params{
    o := orm.NewOrm()
    var subs []orm.Params
    o.QueryTable("weapon").Distinct().Filter("type", typ).Values(&subs, "sub_type")
    if len(subs) > 0 {
        return subs
    } else {
        return []orm.Params{}
    }
}

func AddWeapon(wea Weapon) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&wea)
	if err == nil {
		return id
	} else {
		return 0
	}
}
