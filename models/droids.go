package models

import (
    "github.com/astaxie/beego/orm"
)

func GetDroids() []Droid{
    o := orm.NewOrm()
    var droids []Droid
    o.QueryTable("droid").OrderBy("name").All(&droids)
    if len(droids) > 0 {
        return droids
    } else {
        return []Droid{}
    }
}

func AddDroid(droid Droid) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&droid)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func AddDroidSkill(droSk DroidSkill) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&droSk)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func AddDroidTalent(droTa DroidTalent) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&droTa)
	if err == nil {
		return id
	} else {
		return 0
	}
}
