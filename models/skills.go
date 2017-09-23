package models

import (
    "github.com/astaxie/beego/orm"
)

func GetSkills() []Skill{
    o := orm.NewOrm()
    var skills []Skill
    o.QueryTable("skill").All(&skills)
    if len(skills) > 0 {
        return skills
    } else {
        return []Skill{}
    }
}
