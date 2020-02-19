package game

import (
    "github.com/astaxie/beego/orm"
)

func GetCharacter(p_id int64) Character {
    o := orm.NewOrm()
    player := Character{Id: p_id}
    err := o.Read(&player)
    if err == nil {
        return player
    } else {
        return Character{}
    }
}

func GetCharacterName(name string) Character {
    o := orm.NewOrm()
    var player Character
    err := o.QueryTable("character").Filter("name", name).One(&player)
    if err == nil {
        return player
    } else {
        return Character{}
    }
}

func GetCharacterLike(name string) []Character {
    o := orm.NewOrm()
    var players []Character
    _, err := o.Raw("SELECT * FROM `character` WHERE `name` LIKE CONCAT(?, '%')", name).QueryRows(&players)
    if len(players) > 0 && err == nil {
        return players
    } else {
        return []Character{}
    }
}

func GetCharacters() []Character{
    o := orm.NewOrm()
    var plays []Character
    o.QueryTable("character").OrderBy("name").All(&plays)
    if len(plays) > 0 {
        return plays
    } else {
        return []Character{}
    }
}

func AddCharacter(pla Character) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&pla)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func AddCharTalent(plaTal CharacterTalent) int64 {
    o := orm.NewOrm()
	id, err := o.Insert(&plaTal)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func AddCharForce(plaFor CharacterForce) int64 {
    o := orm.NewOrm()
	id, err := o.Insert(&plaFor)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func GetAddCharacter(name string) (int64, Character) {
    o := orm.NewOrm()
    player := Character{Name: name}
    if created, id, err := o.ReadOrCreate(&player, "name"); err == nil {
        if created {
             return id, Character{}
        } else {
            return id, player
        }
    }
    return 0, Character{}
}
