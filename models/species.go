package models

import (
    "github.com/astaxie/beego/orm"
)

func GetSpecies() []Species{
    o := orm.NewOrm()
    var species []Species
    o.QueryTable("species").All(&species)
    if len(species) > 0 {
        return species
    } else {
        return []Species{}
    }
}

func GetSpecAtt(specId int64) []SpeAttribute {
    o := orm.NewOrm()
    var specAtt []SpeAttribute
    o.QueryTable("spec_attribute").Filter("species_id", specId).All(&specAtt)
    if len(specAtt) > 0 {
        return specAtt
    } else {
        return []SpeAttribute{}
    }
}
