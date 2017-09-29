package models

import (
    "github.com/astaxie/beego/orm"
)

func GetSpecies() []Species{
    o := orm.NewOrm()
    var species []Species
    o.QueryTable("species").OrderBy("name").All(&species)
    if len(species) > 0 {
        return species
    } else {
        return []Species{}
    }
}

func GetSpecAtt(specId int64) []SpeAttribute {
    o := orm.NewOrm()
    var specAtt []SpeAttribute
    o.QueryTable("spe_attribute").Filter("species_id", specId).All(&specAtt)
    if len(specAtt) > 0 {
        return specAtt
    } else {
        return []SpeAttribute{}
    }
}

func AddSpecies(sp Species) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&sp)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func AddSpeAttribute(speAtt SpeAttribute) int64 {
    o := orm.NewOrm()
	id, err := o.Insert(&speAtt)
	if err == nil {
		return id
	} else {
		return 0
	}
}
