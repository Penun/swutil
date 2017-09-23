package models

import (
    "github.com/astaxie/beego/orm"
)

type Career struct {
    Career_id int64 `orm:"pk" json:"career_id"`
    Name string `json:"name"`
    SkillSlots int `json:"skill_slots"`
}

type CareerSkill struct {
    CareerSkill_id int64 `orm:"pk" json:"career_skill_id"`
    Career *Career `orm:"rel(fk)" json:"career"`
    Skill *Skill `orm:"rel(fk)" json:"skill"`
}

type CareerSpec struct {
    CareerSpec_id int64 `orm:"pk" json:"career_spec_id"`
    Career *Career `orm:"rel(fk)" json:"career"`
    Specialization *Specialization `orm:"rel(fk)" json:"specialization"`
}

type Skill struct {
    Skill_id int64 `orm:"pk" json:"skill_id"`
    Name string `json:"name"`
    Type string `json:"type"`
    Characteristic string `json:"characteristic"`
}

type SpeAttribute struct {
    SpeAtt_id int64 `orm:"pk" json:"spe_att_id"`
    Species *Species `orm:"rel(fk)" json:"species"`
    Description string `json:"description"`
}

type SpecSkill struct {
    SpecSkill_id int64 `orm:"pk" json:"spec_skill_id"`
    Specialization *Specialization `orm:"rel(fk)" json:"specialization"`
    Skill *Skill `orm:"rel(fk)" json:"skill"`
}

type SpecTalent struct {
    SpecTalent_id int64 `orm:"pk" json:"spec_talent_id"`
    Specialization *Specialization `orm:"rel(fk)" json:"specialization"`
    Talent *Talent `orm:"rel(fk)" json:"talent"`
    Rank int `json:"rank"`
    Position int `json:position""`
    Right int `json:"right"`
    Down int `json:"down"`
}

type Specialization struct {
    Spec_id int64 `orm:"pk" json:"spec_id"`
    Name string `json:"name"`
    Subtitle string `json:"subtitle"`
    SkillSlots int `json:"skill_slots"`
}

type Species struct {
    Species_id int64 `orm:"pk" json:"species_id"`
    Name string `json:"name"`
    Brawn int `json:"brawn"`
    Agility int `json:"agility"`
    Intellect int `json:"intellect"`
    Cunning int `json:"cunning"`
    Willpower int `json:"willpower"`
    Presence int `json:"presence"`
    WoundThreshold int `json:"wound_threshold"`
    StrainThreshold int `json:"strain_threshold"`
    StartingXp int `json:"starting_xp"`
    RefPage string `json:"ref_page"`
    ImgName string `json:"img_name"`
}

type Talent struct {
    Talent_id int64 `orm:"pk" json:"talent_id"`
    Name string `json:"name"`
    Type string `json:"type"`
    Ranked bool `json:"ranked"`
    Description string `json:"description"`
}

func init() {
    orm.RegisterModel(new(Career), new(CareerSkill), new(CareerSpec), new(Skill), new(SpeAttribute),
        new(SpecSkill), new(SpecTalent), new(Specialization), new(Species), new(Talent))
}
