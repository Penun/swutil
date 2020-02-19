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
    DamageAdd bool `json:"damage_add"`
    DamageSub bool `json:"damage_sub"`
    Critical int `json:"critical"`
    Range string `json:"range"`
    Encumbrance int `json:"encumbrance"`
    HardPoints int `json:"hard_points"`
    Price int `json:"price"`
    Restricted bool `json:"restricted"`
    Rarity int `json:"rarity"`
    Special string `json:"special"`
    Description string `json:"description"`
    Book string `json:"book"`
}

type WeaponModel struct {
    Id int64 `orm:"pk" json:"id"`
    Weapon *Weapon `orm:"rel(fk)" json:"weapon"`
    Model string `json:"model"`
    Description string `json:"description"`
}

type Armor struct {
    Id int64 `orm:"pk" json:"id"`
    Type string `json:"type"`
    Defense int `json:"defense"`
    Soak int `json:"soak"`
    Price int `json:"price"`
    Restricted bool `json:"restricted"`
    Encumbrance int `json:"encumbrance"`
    HardPoints int `json:"hard_points"`
    Rarity int `json:"rarity"`
    Description string `json:"description"`
    Book string `json:"book"`
}

type ArmorModel struct {
    Id int64 `orm:"pk" json:"id"`
    Armor *Armor `orm:"rel(fk)" json:"armor"`
    Model string `json:"model"`
    Description string `json:"description"`
}

type Gear struct {
    Id int64 `orm:"pk" json:"id"`
    Item string `json:"item"`
    Type string `json:"type"`
    Price int `json:"price"`
    Restricted bool `json:"restricted"`
    Encumbrance int `json:"encumbrance"`
    Rarity int `json:"rarity"`
    Description string `json:"description"`
    Book string `json:"book"`
}

type GearModel struct {
    Id int64 `orm:"pk" json:"id"`
    Gear *Gear `orm:"rel(fk)" json:"gear"`
    Model string `json:"model"`
    Description string `json:"description"`
}

type Attachment struct {
    Id int64 `orm:"pk" json:"id"`
    Name string `json:"name"`
    Type string `json:"type"`
    Price int `json:"price"`
    Restricted bool `json:"restricted"`
    Encumbrance int `json:"encumbrance"`
    HpRequired int `json:"hp_required"`
    Rarity int `json:"rarity"`
    Description string `json:"description"`
    Book string `json:"book"`
    BaseMod string `json:"base_mod"`
}

type AttachmentModel struct {
    Id int64 `orm:"pk" json:"id"`
    Attachment *Attachment `orm:"rel(fk)" json:"attachment"`
    Model string `json:"model"`
}

type ModificationOption struct {
    Id int64 `orm:"pk" json:"id"`
    Option string `json:"option"`
    Description string `json:"description"`
}

type AttachmentModificationOption struct {
    Id int64 `orm:"pk" json:"id"`
    Attachment *Attachment `orm:"rel(fk)" json:"attachment"`
    ModificationOption *ModificationOption `orm:"rel(fk)" json:"modification_option"`
}

type Droid struct {
    Id int64 `orm:"pk" json:"id"`
    Name string `json:"name"`
    Price int `json:"price"`
    Restricted bool `json:"restricted"`
    Rarity int `json:"rarity"`
    Brawn int `json:"brawn"`
    Agility int `json:"agility"`
    Intellect int `json:"intellect"`
    Cunning int `json:"cunning"`
    Willpower int `json:"willpower"`
    Presence int `json:"presence"`
    SoakValue int `json:"soak_value"`
    WoundThreshold int `json:"wound_threshold"`
    DefenseMelee int `json:"defense_melee"`
    DefenseRanged int `json:"defense_ranged"`
    Abilities string `json:"abilities"`
    Equipment string `json:"equipment"`
    Description string `json:"description"`
    Book string `json:"book"`
}

type DroidSkill struct {
    Id int64 `orm:"pk" json:"id"`
    Droid *Droid `orm:"rel(fk)" json:"droid"`
    Skill *Skill `orm:"rel(fk)" json:"skill"`
    Ranks int `json:"ranks"`
}

type DroidTalent struct {
    Id int64 `orm:"pk" json:"id"`
    Droid *Droid `orm:"rel(fk)" json:"droid"`
    Talent *Talent `orm:"rel(fk)" json:"talent"`
    Ranks int `json:"ranks"`
}

type Vehicle struct {
    Id int64 `orm:"pk" json:"id"`
    Model string `json:"model"`
    Type string `json:"type"`
    Silhouette int `json:"silhouette"`
    Speed int `json:"speed"`
    Handling int `json:"handling"`
    DefForward int `json:"def_forward"`
    DefAft int `json:"def_aft"`
    DefStarboard int `json:"def_starboard"`
    DefPort int `json:"def_port"`
    Armor int `json:"armor"`
    SsThreshold int `json:"ss_threshold"`
    HtThreshold int `json:"ht_threshold"`
    Manufacturer string `json:"manufacturer"`
    MaxAltitude int `json:"max_altitude"`
    SensorRange string `json:"sensor_range"`
    Crew string `json:"crew"`
    EncCapacity string `json:"crew"`
    PassCapacity string `json:"pass_capacity"`
    Cost int `json:"cost"`
    Rarity int `json:"rarity"`
    HardPoints int `json:"hard_points"`
    Description string `json:"description"`
    Weapons string `json:"weapons"`
    Book string `json:"book"`
}

type Starship struct {
    Id int64 `orm:"pk" json:"id"`
    Model string `json:"model"`
    Type string `json:"type"`
    Silhouette int `json:"silhouette"`
    Speed int `json:"speed"`
    Handling int `json:"handling"`
    DefForward int `json:"def_forward"`
    DefAft int `json:"def_aft"`
    DefStarboard int `json:"def_starboard"`
    DefPort int `json:"def_port"`
    Armor int `json:"armor"`
    HtThreshold int `json:"ht_threshold"`
    SsThreshold int `json:"ss_threshold"`
    Manufacturer string `json:"manufacturer"`
    Hyperdrive string `json:"hyperdrive"`
    Navicomputer string `json:"navicomputer"`
    SensorRange string `json:"sensor_range"`
    Complement string `json:"complement"`
    EncCapacity string `json:"enc_capacity"`
    PassCapacity string `json:"pass_capacity"`
    Consumables string `json:"consumables"`
    Cost int `json:"cost"`
    Rarity int `json:"rarity"`
    HardPoints int `json:"hard_points"`
    Weapons string `json:"weapons"`
    Customizations string `json:"customizations"`
    Description string `json:"description"`
    Book string `json:"book"`
}

type Force struct {
    Id int64 `orm:"pk" json:"id"`
    Name string `json:"name"`
    Description string `json:"description"`
    Base string `json:"base"`
}

func init() {
    orm.RegisterModel(new(Career), new(CareerSkill), new(CareerSpec), new(Skill), new(SpeAttribute),
        new(SpecSkill), new(SpecTalent), new(Specialization), new(Species), new(Talent), new(Weapon),
        new(WeaponModel), new(Armor), new(ArmorModel), new(Gear), new(GearModel), new(Attachment),
        new(AttachmentModel), new(ModificationOption), new(AttachmentModificationOption), new(Droid),
        new(DroidSkill), new(DroidTalent), new(Vehicle), new(Starship), new(Force))
}
