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
    uname := ""
	if findPlay := this.GetSession("player"); findPlay != nil {
		uname = findPlay.(string)
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
			tempPlay := game.LivePlayer{Player: &newPlay, IsTurn: false, Type: "PC", DispStats: true}
			tempPlay.CurWound = newPlay.Wound
			tempPlay.CurStrain = newPlay.Strain
			players = append(players, tempPlay)
			go UpdateCurIndByIsTurn()
			this.SetSession("player", uname)
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

    ws_type := "play"
	// Join chat room.
	gamesocket.Join(uname, ws_type, ws)
	defer gamesocket.Leave(uname)

	// Message receive loop.
	for {
		_, adj, err := ws.ReadMessage()
		if err != nil {
			return
		}
		var conReq ControllerReq
		err = json.Unmarshal(adj, &conReq)
		if err == nil {
			switch conReq.Type {
			case "note":
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_NOTE, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "wound":
				wound, _ := strconv.Atoi(conReq.Data.Message)
				WoundPlayer(uname, wound)
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_WOUND, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "strain":
				strain, _ := strconv.Atoi(conReq.Data.Message)
				StrainPlayer(uname, strain)
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_STRAIN, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative":
				init, _ := strconv.ParseFloat(conReq.Data.Message, 64)
				InitPlayer(uname, init)
				go SortPlayerInit()
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_INIT, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative_t":
				players[curInitInd].IsTurn = false
				if curInitInd == len(players) - 1 {
					curInitInd = 0
				} else {
					curInitInd++
				}
				players[curInitInd].IsTurn = true
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_INIT_T, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			}
            beego.Info("Players", players)
            beego.Info("Current Init", curInitInd)
		} else {
			beego.Error(err.Error())
		}
	}
}
