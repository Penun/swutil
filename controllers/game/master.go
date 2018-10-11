package game

import (
    "strconv"
    "encoding/json"
    "github.com/astaxie/beego"
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
            passPublish := false
			switch conReq.Type {
			case gamesocket.EVENT_WOUND:
				wound, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					WoundPlayer(play, wound)
				}
			case gamesocket.EVENT_STRAIN:
				strain, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					StrainPlayer(play, strain)
				}
			case gamesocket.EVENT_INIT:
				if !initStarted {
					init, _ := strconv.ParseFloat(conReq.Data.Message, 64)
					for _, play := range conReq.Data.Players {
						InitPlayer(play, init)
					}
					go SortPlayerInit()
				} else {
                    passPublish = true
                }
			case gamesocket.EVENT_INIT_D:
				for _, play := range conReq.Data.Players {
					InitPlayer(play, 0)
				}
				go SortPlayerInit()
			case gamesocket.EVENT_INIT_S:
				if len(players) > 0 {
					initStarted = true
					FindNextInitInd(true, false)
					players[curInitInd].IsTurn = true
				} else {
                    passPublish = true
                }
			case gamesocket.EVENT_INIT_E:
				initStarted = false
				curInitInd = 0
				for i := 0; i < len(players); i++ {
					players[i].IsTurn = false
				}
			case gamesocket.EVENT_INIT_T:
				players[curInitInd].IsTurn = false
				if conReq.Data.Message == "+" {
					FindNextInitInd(false, false)
				} else {
					FindNextInitInd(false, true)
				}
				players[curInitInd].IsTurn = true
			case gamesocket.EVENT_JOIN:
				var newPlay LivePlayer
				err = json.Unmarshal([]byte(conReq.Data.Message), &newPlay)
				if err == nil {
					players = append(players, newPlay)
					SortPlayerInit()
					UpdateCurIndByIsTurn()
				} else {
                    passPublish = true
					beego.Error(err.Error())
				}
			case gamesocket.EVENT_LEAVE:
				for _, play := range conReq.Data.Players {
					DeletePlayerName(play)
					gamesocket.Leave(play)
				}
			case gamesocket.EVENT_BOOST:
				boost, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					BoostPlayer(play, boost)
				}
			case gamesocket.EVENT_SETBACK:
				setback, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					SetbackPlayer(play, setback)
				}
			case gamesocket.EVENT_UPGRADE:
				upgrade, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					UpgradePlayer(play, upgrade)
				}
			case gamesocket.EVENT_UPDIFF:
				upDiff, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					UpDiffPlayer(play, upDiff)
				}
            case gamesocket.EVENT_TEAM:
                team, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					SetPlayTeam(play, team)
				}
            default:
                passPublish = true
			}
            if !passPublish {
                gamesocket.Publish <- gamesocket.NewEvent(conReq.Type, uname, ws_type, conReq.Data.Players, conReq.Data.Message)
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
