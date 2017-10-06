package models

import (
    "github.com/astaxie/beego/orm"
)

func GetTalents() []Talent{
    o := orm.NewOrm()
    var talents []Talent
    o.QueryTable("talent").OrderBy("name").All(&talents)
    if len(talents) > 0 {
        return talents
    } else {
        return []Talent{}
    }
}

func GetTalentsBySpecial(spId int64) []SpecTalent {
    o := orm.NewOrm()
    var specTals []SpecTalent
    o.QueryTable("spec_talent").Filter("specialization_id", spId).RelatedSel("talent").All(&specTals)
    if len(specTals) > 0 {
        return specTals
    } else {
        return []SpecTalent{}
    }
}

func AddTalent(ta Talent) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&ta)
	if err == nil {
		return id
	} else {
		return 0
	}
}
