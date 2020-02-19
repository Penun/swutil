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
	this.TplName = "game/end.html"

	// Upgrade from http request to WebSocket.
	ws, err := gamesocket.Upgrade(this.Ctx.ResponseWriter, this.Ctx.Request)
    if err != nil {
		beego.Error("Cannot setup WebSocket connection:", err)
		return
	}

	// Join update channel.
	sub_id := gamesocket.Join(uname, gamesocket.SUB_MASTER, ws)
	defer masterLeave(sub_id)

    gamesocket.Publish <- gamesocket.NewEvent(EVENT_JOIN, gamesocket.SUB_MASTER, gamesocket.SUB_MASTER, nil, "", true)

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
            sendAll := false
			switch conReq.Type {
			case EVENT_WOUND:
				wound, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					WoundPlayer(play, wound)
				}
			case EVENT_STRAIN:
				strain, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					StrainPlayer(play, strain)
				}
			case EVENT_INIT:
				if !initStarted {
					init, _ := strconv.ParseFloat(conReq.Data.Message, 64)
					for _, play := range conReq.Data.Players {
						InitPlayer(play, init)
					}
					go SortPlayerInit()
				} else {
                    passPublish = true
                }
			case EVENT_INIT_D:
				for _, play := range conReq.Data.Players {
					InitPlayer(play, 0)
				}
				go SortPlayerInit()
			case EVENT_INIT_S:
				if len(players) > 0 {
					initStarted = true
					FindNextInitInd(true, false)
					players[curInitInd].IsTurn = true
                    sendAll = true
				} else {
                    passPublish = true
                }
			case EVENT_INIT_E:
				initStarted = false
				curInitInd = 0
				for i := 0; i < len(players); i++ {
					players[i].IsTurn = false
				}
                sendAll = true
			case EVENT_INIT_T:
				players[curInitInd].IsTurn = false
				if conReq.Data.Message == "+" {
					FindNextInitInd(false, false)
				} else {
					FindNextInitInd(false, true)
				}
				players[curInitInd].IsTurn = true
			case EVENT_JOIN:
				var newPlay LivePlayer
				err = json.Unmarshal([]byte(conReq.Data.Message), &newPlay)
				if err == nil {
                    curPlayId++
                    newPlay.Id = curPlayId
                    type tmpPlay struct {
                        Name string `json:"name"`
                        Wound int `json:"wound"`
                        Strain int `json:"strain"`
                    }
                    type tmpLivePlay struct {
                        Id int `json:"id"`
                    	Character tmpPlay `json:"player"`
                    	Initiative float64 `json:"initiative"`
                        CurWound int `json:"cur_wound"`
                        CurStrain int `json:"cur_strain"`
                        CurBoost int `json:"cur_boost"`
                        CurSetback int `json:"cur_setback"`
                        CurUpgrade int `json:"cur_upgrade"`
                        CurUpDiff int `json:"cur_upDiff"`
                        IsTurn bool `json:"isTurn"`
                    	Type string `json:"type"`
                    	Team int `json:"team"`
                        DispStats bool `json:"disp_stats"`
                    }
                    nTmpPlay := tmpLivePlay{
                        Id: newPlay.Id,
                        Character: tmpPlay{Name: newPlay.Character.Name, Wound: newPlay.Character.Wound, Strain: newPlay.Character.Strain},
                        Initiative: newPlay.Initiative,
                        CurWound: newPlay.CurWound,
                        CurStrain: newPlay.CurStrain,
                        CurBoost: newPlay.CurBoost,
                        CurSetback: newPlay.CurSetback,
                        CurUpgrade: newPlay.CurUpgrade,
                        CurUpDiff: newPlay.CurUpDiff,
                        IsTurn: newPlay.IsTurn,
                    	Type: newPlay.Type,
                    	Team: newPlay.Team,
                        DispStats: newPlay.DispStats}
                    newPlayJson, err := json.Marshal(nTmpPlay)
                    if err == nil {
                        players = append(players, newPlay)
                        UpdateCurIndByIsTurn()
                        SortPlayerInit()
                        conReq.Data.Message = string(newPlayJson)
                    } else {
                        passPublish = true
                        curPlayId--
                        beego.Error(err.Error())
                    }
				} else {
                    passPublish = true
					beego.Error(err.Error())
				}
			case EVENT_LEAVE:
				for _, play := range conReq.Data.Players {
                    player := GetPlayerId(play)
                    if player.subId > 0 {
                        gamesocket.Leave(player.subId)
                    }
                    DeletePlayerId(play)

				}
			case EVENT_BOOST:
				boost, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					BoostPlayer(play, boost)
				}
			case EVENT_SETBACK:
				setback, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					SetbackPlayer(play, setback)
				}
			case EVENT_UPGRADE:
				upgrade, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					UpgradePlayer(play, upgrade)
				}
			case EVENT_UPDIFF:
				upDiff, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					UpDiffPlayer(play, upDiff)
				}
            case EVENT_TEAM:
                team, _ := strconv.Atoi(conReq.Data.Message)
				for _, play := range conReq.Data.Players {
					SetPlayTeam(play, team)
				}
            default:
                passPublish = true
			}
            if !passPublish {
                multiMessStr, _ := json.Marshal(conReq.Data)
                targs := findTargs(conReq.Type, conReq.Data.Players)
                gamesocket.Publish <- gamesocket.NewEvent(conReq.Type, gamesocket.SUB_MASTER, gamesocket.SUB_MASTER, targs, string(multiMessStr), sendAll)
            }
            beego.Info("Players ", players)
            beego.Info("Current Init ", curInitInd)
		} else {
			beego.Error(err.Error())
		}
	}
}

func findTargs(eType int, playIds []int) []int {
    var foundSubs []int
    for _, play := range playIds {
        if player := GetPlayerId(play); (player != LivePlayer{}) {
            if player.subId != 0 {
                foundSubs = append(foundSubs, player.subId)
            }
        }
    }
    return foundSubs
}

func masterLeave(uId int) {
    master = false
    gamesocket.Leave(uId)
}
