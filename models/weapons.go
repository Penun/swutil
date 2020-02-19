package models

import (
    "github.com/astaxie/beego/orm"
)

func GetWeapons() []Weapon{
    o := orm.NewOrm()
    var weapons []Weapon
    o.QueryTable("weapon").OrderBy("name", "type", "sub_type").All(&weapons)
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

func GetWeaponsByType(typ string, restricted bool) []Weapon{
    o := orm.NewOrm()
    var weaps []Weapon
    o.QueryTable("weapon").Filter("type", typ).Filter("restricted", restricted).RelatedSel("skill").All(&weaps)
    if len(weaps) > 0 {
        return weaps
    } else {
        return []Weapon{}
    }
}

func GetWeaponModels(id int64) []WeaponModel{
    o := orm.NewOrm()
    var weaps []WeaponModel
    o.QueryTable("weapon_model").Filter("weapon_id", id).All(&weaps)
    if len(weaps) > 0 {
        return weaps
    } else {
        return []WeaponModel{}
    }
}

func GetWeaponsBySub(typ string) []Weapon{
    o := orm.NewOrm()
    var weaps []Weapon
    o.QueryTable("weapon").Filter("sub_type", typ).OrderBy("skill_id", "range", "damage", "name").All(&weaps)
    if len(weaps) > 0 {
        return weaps
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
