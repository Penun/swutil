package models

import (
    "github.com/astaxie/beego/orm"
)

func GetWeapons() []Weapon{
    o := orm.NewOrm()
    var weapons []Weapon
    o.QueryTable("weapon").OrderBy("type").OrderBy("sub_type").OrderBy("name").All(&weapons)
    if len(weapons) > 0 {
        return weapons
    } else {
        return []Weapon{}
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
