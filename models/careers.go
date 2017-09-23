package models

import (
    "github.com/astaxie/beego/orm"
)

func GetCareers() []Career{
    o := orm.NewOrm()
    var careers []Career
    o.QueryTable("career").All(&careers)
    if len(careers) > 0 {
        return careers
    } else {
        return []Career{}
    }
}
