package game

import (
    "github.com/astaxie/beego/orm"
    "github.com/Penun/swutil/models"
)

type EventType int

const (
	EVENT_JOIN = iota //0
	EVENT_LEAVE //1
	EVENT_NOTE //2
	EVENT_WOUND //3
	EVENT_STRAIN //4
	EVENT_INIT //5
	EVENT_INIT_D //6
	EVENT_INIT_S //7
	EVENT_INIT_T //8
	EVENT_INIT_E //9
    EVENT_BOOST //10
    EVENT_SETBACK //11
    EVENT_UPGRADE //12
    EVENT_UPDIFF //13
)

type Event struct {
	Type EventType `json:"type"`
	Sender Sender `json:"sender"`
	Targets []string `json:"targets"`
	Data string `json:"data"`
}

type Player struct {
	Id int64 `orm:"pk" json:"id"`
    Name string `json:"name"`
    Species *models.Species `orm:"rel(fk)" json:"species"`
	Wound int `json:"wound"`
    Strain int `json:"strain"`
    Brawn int `json:"brawn"`
    Agility int `json:"agility"`
    Intellect int `json:"intellect"`
    Cunning int `json:"cunning"`
    Willpower int `json:"willpower"`
    Presence int `json:"presence"`
    Astrogation int `json:"astrogation"`
    Athletics int `json:"athletics"`
    Brawl int `json:"brawl"`
    Charm int `json:"charm"`
    Coercion int `json:"coercion"`
    Computers int `json:"computers"`
    Cool int `json:"cool"`
    Coordination int `json:"coordination"`
    CoreWorlds int `json:"core_worlds"`
    Deception int `json:"deception"`
    Discipline int `json:"discipline"`
    Education int `json:"education"`
    Gunnery int `json:"gunnery"`
    Leadership int `json:"leadership"`
    Lightsaber int `json:"lightsaber"`
    Lore int `json:"lore"`
    Mechanics int `json:"mechanics"`
    Medicine int `json:"medicine"`
    Melee int `json:"melee"`
    Negotiation int `json:"negotiation"`
    OuterRim int `json:"outer_rim"`
    Perception int `json:"perception"`
    PilotingP int `json:"piloting_p"`
    PilotingS int `json:"piloting_s"`
    RangedH int `json:"ranged_h"`
    RangedL int `json:"ranged_l"`
    Resilience int `json:"resilience"`
    Skulduggery int `json:"skulduggery"`
    Stealth int `json:"stealth"`
    Streetwise int `json:"streetwise"`
    Survival int `json:"survival"`
    Underworld int `json:"underworld"`
    Vigilance int `json:"vigilance"`
    Warfare int `json:"warfare"`
    Xenology int `json:"xenology"`
    Notes string `json:"notes"`
}

type PlayerTalent struct {
    Id int64 `orm:"pk" json:"id"`
    Player *Player `orm:"rel(fk)" json:"player"`
    Talent *models.Talent `orm:"rel(fk)" json:"talent"`
    Rank int `json:"rank"`
}

type PlayerForce struct {
    Id int64 `orm:"pk" json:"id"`
    Player *Player `orm:"rel(fk)" json:"player"`
    Force *models.Force `orm:"rel(fk)" json:"force"`
}

type LivePlayer struct {
	Player *Player `json:"player"`
	Initiative float64 `json:"initiative"`
    CurWound int `json:"cur_wound"`
    CurStrain int `json:"cur_strain"`
    CurBoost int `json:"cur_boost"`
    CurSetback int `json:"cur_setback"`
    CurUpgrade int `json:"cur_upgrade"`
    CurUpDiff int `json:"cur_upDiff"`
    IsTurn bool `json:"isTurn"`
	Type string `json:"type"`
}

type Sender struct {
	Name string `json:"name"`
	Type string `json:"type"`
}

func init() {
	orm.RegisterModel(new(Player), new(PlayerTalent), new(PlayerForce))
}
