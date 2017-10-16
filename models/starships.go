package models

import (
    "github.com/astaxie/beego/orm"
)

func GetStarships() []Starship{
    o := orm.NewOrm()
    var stars []Starship
    o.QueryTable("starship").OrderBy("type", "model").All(&stars)
    if len(stars) > 0 {
        return stars
    } else {
        return []Starship{}
    }
}

func AddStarship(star Starship) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&star)
	if err == nil {
		return id
	} else {
		return 0
	}
}
