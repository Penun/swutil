package sockets

import (
    "github.com/astaxie/beego/orm"
)

func GetPlayer(p_id int64) Player {
    o := orm.NewOrm()
    player := Player{Id: p_id}
    err := o.Read(&player)
    if err == nil {
        return player
    } else {
        return Player{}
    }
}

func GetPlayerLike(name string) []Player {
    o := orm.NewOrm()
    var players []Player
    _, err := o.Raw("SELECT * FROM `player` WHERE `name` LIKE '?%''", name).QueryRows(&players)
    if len(players) > 0 && err == nil {
        return players
    } else {
        return []Player{}
    }
}

func GetPlayers() []Player{
    o := orm.NewOrm()
    var plays []Player
    o.QueryTable("player").OrderBy("name").All(&plays)
    if len(plays) > 0 {
        return plays
    } else {
        return []Player{}
    }
}

func AddPlayer(pla Player) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&pla)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func AddPlayTalent(plaTal PlayerTalent) int64 {
    o := orm.NewOrm()
	id, err := o.Insert(&plaTal)
	if err == nil {
		return id
	} else {
		return 0
	}
}

func GetAddPlayer(name string) (int64, Player) {
    o := orm.NewOrm()
    player := Player{Name: name}
    if created, id, err := o.ReadOrCreate(&player, "name"); err == nil {
        if created {
             return id, Player{}
        } else {
            return id, player
        }
    }
    return 0, Player{}
}
