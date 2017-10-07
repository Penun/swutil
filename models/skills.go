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

func GetSkillsByCareer(careId int64) []CareerSkill {
    o := orm.NewOrm()
    var cSKill []CareerSkill
    o.QueryTable("career_skill").Filter("career_id", careId).All(&cSKill)
    if len(cSKill) > 0 {
        return cSKill
    } else {
        return []CareerSkill{}
    }
}

func GetSkillsBySpecial(speId int64) []SpecSkill {
    o := orm.NewOrm()
    var sSkill []SpecSkill
    o.QueryTable("spec_skill").Filter("specialization_id", speId).All(&sSkill)
    if len(sSkill) > 0 {
        return sSkill
    } else {
        return []SpecSkill{}
    }
}
