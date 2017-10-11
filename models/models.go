package models

import (
    "github.com/astaxie/beego/orm"
)

type Career struct {
    Id int64 `orm:"pk" json:"id"`
    Name string `json:"name"`
    SkillSlots int `json:"skill_slots"`
}

type CareerSkill struct {
    Id int64 `orm:"pk" json:"id"`
    Career *Career `orm:"rel(fk)" json:"career"`
    Skill *Skill `orm:"rel(fk)" json:"skill"`
}

type CareerSpec struct {
    Id int64 `orm:"pk" json:"id"`
    Career *Career `orm:"rel(fk)" json:"career"`
    Specialization *Specialization `orm:"rel(fk)" json:"specialization"`
}

type Skill struct {
    Id int64 `orm:"pk" json:"id"`
    Name string `json:"name"`
    Type string `json:"type"`
    Characteristic string `json:"characteristic"`
}

type SpeAttribute struct {
    Id int64 `orm:"pk" json:"id"`
    Species *Species `orm:"rel(fk)" json:"species"`
    Description string `json:"description"`
}

type SpecSkill struct {
    Id int64 `orm:"pk" json:"id"`
    Specialization *Specialization `orm:"rel(fk)" json:"specialization"`
    Skill *Skill `orm:"rel(fk)" json:"skill"`
}

type SpecTalent struct {
    Id int64 `orm:"pk" json:"id"`
    Specialization *Specialization `orm:"rel(fk)" json:"specialization"`
    Talent *Talent `orm:"rel(fk)" json:"talent"`
    Rank int `json:"rank"`
    Position int `json:"position"`
    Right bool `json:"right"`
    Down bool `json:"down"`
}

type Specialization struct {
    Id int64 `orm:"pk" json:"id"`
    Name string `json:"name"`
    Subtitle string `json:"subtitle"`
    SkillSlots int `json:"skill_slots"`
}

type Species struct {
    Id int64 `orm:"pk" json:"id"`
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
    Id int64 `orm:"pk" json:"id"`
    Name string `json:"name"`
    Type string `json:"type"`
    Ranked bool `json:"ranked"`
    Description string `json:"description"`
}

type Weapon struct {
    Id int64 `orm:"pk" json:"id"`
    Type string `json:"type"`
    SubType string `json:"sub_type"`
    Name string `json:"name"`
    Skill *Skill `orm:"rel(fk)" json:"skill"`
    Damage int `json:"damage"`
    Critical int `json:"critical"`
    Range string `json:"range"`
    Ecumberance int `json:"ecumberance"`
    HardPoints int `json:"hard_points"`
    Price int `json:"price"`
    Restricted int `json:"restricted"`
    Rarity int `json:"rarity"`
    Special string `json:"special"`
    Description string `json:"description"`
}

func init() {
    orm.RegisterModel(new(Career), new(CareerSkill), new(CareerSpec), new(Skill), new(SpeAttribute),
        new(SpecSkill), new(SpecTalent), new(Specialization), new(Species), new(Talent), new(Weapon))
}
