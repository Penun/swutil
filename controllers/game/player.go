package game

import (
    "strconv"
    "encoding/json"
    "github.com/astaxie/beego"
    "github.com/Penun/swutil/models/game"
    "github.com/Penun/swutil/controllers/game/gamesocket"
)

type PlayerSocketController struct {
	beego.Controller
}

func (this *PlayerSocketController) Join() {
    var (
        playId int
        uname string
    )
	if findPlay := this.GetSession("player"); findPlay != nil {
		playId = findPlay.(int)
        tempPlay := GetPlayerId(playId)
        uname = tempPlay.Player.Name
	} else {
		uname = this.GetString("uname")
		if len(uname) == 0 {
			this.Redirect("/", 302)
			return
		}
		if gamesocket.IfUserExist(uname) {
			this.Redirect("/", 302)
			return
		}
		if newPlay := game.GetPlayerName(uname); (newPlay != game.Player{}) {
            curPlayId++
			tempPlay := LivePlayer{Player: &newPlay, IsTurn: false, Type: "PC", Team: 0, DispStats: true, CurWound: newPlay.Wound, CurStrain: newPlay.Strain}
            tempPlay.Id = curPlayId
            playId = curPlayId
			players = append(players, tempPlay)
			go UpdateCurIndByIsTurn()
			this.SetSession("player", playId)
		} else {
			this.Redirect("/", 302)
			return
		}
	}

	this.TplName = "game/end.html"

	// Upgrade from http request to WebSocket.
    ws, err := gamesocket.Upgrade(this.Ctx.ResponseWriter, this.Ctx.Request)
    if err != nil {
		beego.Error("Cannot setup WebSocket connection:", err)
		return
	}

	// Join update list
	sub_id := gamesocket.Join(uname, gamesocket.SUB_CLIENT, ws)
	defer gamesocket.Leave(sub_id)
    setSubId(playId, sub_id)

    gamesocket.Publish <- gamesocket.NewEvent(EVENT_JOIN, playId, gamesocket.SUB_CLIENT, nil, "")

	// Message receive loop.
	for {
		_, adj, err := ws.ReadMessage()
		if err != nil {
			return
		}
		var conReq ControllerReq
		err = json.Unmarshal(adj, &conReq)
		if err == nil {
            passPublish := false
			switch conReq.Type {
			case EVENT_WOUND:
				wound, _ := strconv.Atoi(conReq.Data.Message)
				WoundPlayer(playId, wound)
			case EVENT_STRAIN:
				strain, _ := strconv.Atoi(conReq.Data.Message)
				StrainPlayer(playId, strain)
			case EVENT_INIT:
				init, _ := strconv.ParseFloat(conReq.Data.Message, 64)
				InitPlayer(playId, init)
				go SortPlayerInit()
			case EVENT_INIT_T:
				players[curInitInd].IsTurn = false
				if curInitInd == len(players) - 1 {
					curInitInd = 0
				} else {
					curInitInd++
				}
				players[curInitInd].IsTurn = true
            default:
                passPublish = true
			}
            if !passPublish {
                gamesocket.Publish <- gamesocket.NewEvent(conReq.Type, playId, gamesocket.SUB_CLIENT, conReq.Data.Players, conReq.Data.Message)
            }
            beego.Info("Players: ", players)
            beego.Info("Current Init: ", curInitInd)
		} else {
			beego.Error(err.Error())
		}
	}
}
