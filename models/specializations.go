package models

import (
    "github.com/astaxie/beego/orm"
)

func GetSpecializations() []Specialization{
    o := orm.NewOrm()
    var specializations []Specialization
    o.QueryTable("specialization").All(&specializations)
    if len(specializations) > 0 {
        return specializations
    } else {
        return []Specialization{}
    }
}

func AddSpecialization(spec Specialization) int64 {
    o := orm.NewOrm()
	id, err := o.Insert(&spec)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func AddSpecSkill(spSk SpecSkill) int64 {
    o := orm.NewOrm()
	id, err := o.Insert(&spSk)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func AddSpecTalent(spTa SpecTalent) int64 {
    o := orm.NewOrm()
	id, err := o.Insert(&spTa)
	if err == nil {
		return id
	} else {
		return 0
	}
}
