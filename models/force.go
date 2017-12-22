package models

import (
    "github.com/astaxie/beego/orm"
)

func GetForce() []Force{
    o := orm.NewOrm()
    var force []Force
    o.QueryTable("force").All(&force)
    if len(force) > 0 {
        return force
    } else {
        return []Force{}
    }
}
