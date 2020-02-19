package models

import (
    "github.com/astaxie/beego/orm"
)

func GetArmor() []Armor{
    o := orm.NewOrm()
    var armor []Armor
    o.QueryTable("armor").OrderBy("type", "defense", "soak", "hard_points").All(&armor)
    if len(armor) > 0 {
        return armor
    } else {
        return []Armor{}
    }
}

func GetArmorRestricted(restricted bool) []Armor {
    o := orm.NewOrm()
    var armor []Armor
    o.QueryTable("armor").Filter("restricted", restricted).All(&armor)
    if len(armor) > 0 {
        return armor
    } else {
        return []Armor{}
    }
}

func GetArmorModels(id int64) []ArmorModel {
    o := orm.NewOrm()
    var arms []ArmorModel
    o.QueryTable("armor_model").Filter("armor_id", id).All(&arms)
    if len(arms) > 0 {
        return arms
    } else {
        return []ArmorModel{}
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
