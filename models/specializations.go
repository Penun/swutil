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
