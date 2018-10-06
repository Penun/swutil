package game

import (
    "strconv"
    "encoding/json"
    "github.com/astaxie/beego"
    "github.com/Penun/swutil/models/game"
    "github.com/Penun/swutil/controllers/game/gamesocket"
)

type MasterSocketController struct {
	beego.Controller
}

func (this *MasterSocketController) Join() {
	if !master{
		master = true
	} else {
		this.Redirect("/", 302)
		return
	}

	uname := "GM"
	ws_type := "master"

	this.TplName = "game/end.html"

	// Upgrade from http request to WebSocket.
	ws, err := gamesocket.Upgrade(this.Ctx.ResponseWriter, this.Ctx.Request)
    if err != nil {
		beego.Error("Cannot setup WebSocket connection:", err)
		return
	}

	// Join update channel.
	gamesocket.Join(uname, ws_type, ws)
	defer MasterLeave(uname)

	// Message receive loop.
	for {
		_, req, err := ws.ReadMessage()
		if err != nil {
			return
		}

		var conReq ControllerReq
		err = json.Unmarshal(req, &conReq)
		if err == nil {
			switch conReq.Type {
			case "note":
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_NOTE, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "wound":
				wound, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					WoundPlayer(play, wound)
				}
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_WOUND, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "strain":
				strain, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					StrainPlayer(play, strain)
				}
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_STRAIN, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative":
				if !initStarted {
					init, _ := strconv.ParseFloat(conReq.Data.Message, 64)
					for _, play := range conReq.Data.Players {
						InitPlayer(play, init)
					}
					go SortPlayerInit()
					gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_INIT, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
				}
			case "initiative_d":
				for _, play := range conReq.Data.Players {
					InitPlayer(play, 0)
				}
				go SortPlayerInit()
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_INIT_D, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative_s":
				if len(players) > 0 {
					initStarted = true
					FindNextInitInd(true, false)
					players[curInitInd].IsTurn = true
					gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_INIT_S, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
				}
			case "initiative_e":
				initStarted = false
				curInitInd = 0
				for i := 0; i < len(players); i++ {
					players[i].IsTurn = false
				}
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_INIT_E, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "initiative_t":
				players[curInitInd].IsTurn = false
				if conReq.Data.Message == "+" {
					FindNextInitInd(false, false)
				} else {
					FindNextInitInd(false, true)
				}
				players[curInitInd].IsTurn = true
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_INIT_T, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "add":
				var newPlay game.LivePlayer
				err = json.Unmarshal([]byte(conReq.Data.Message), &newPlay)
				if err == nil {
					players = append(players, newPlay)
					SortPlayerInit()
					UpdateCurIndByIsTurn()
					gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_JOIN, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
				} else {
					beego.Error(err.Error())
				}
			case "delete":
				for _, play := range conReq.Data.Players {
					DeletePlayerName(play)
					gamesocket.Leave(play)
				}
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_LEAVE, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "boost":
				boost, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					BoostPlayer(play, boost)
				}
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_BOOST, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "setback":
				setback, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					SetbackPlayer(play, setback)
				}
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_SETBACK, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "upgrade":
				upgrade, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					UpgradePlayer(play, upgrade)
				}
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_UPGRADE, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			case "upDiff":
				upDiff, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					UpDiffPlayer(play, upDiff)
				}
				gamesocket.Publish <- gamesocket.NewEvent(game.EVENT_UPDIFF, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
			}
            beego.Info("Players", players)
            beego.Info("Current Init", curInitInd)
		} else {
			beego.Error(err.Error())
		}
	}
}

func MasterLeave(uname string) {
    master = false
    gamesocket.Leave(uname)
}
