package game

import (
    "time"
    "strconv"
    "github.com/astaxie/beego"
    "github.com/Penun/swutil/controllers/game/gamesocket"
)

type WatchSocketController struct {
	beego.Controller
}

func (this *WatchSocketController) Join() {
    uname := "watch" + strconv.FormatInt(time.Now().Unix(), 10)

	this.TplName = "game/end.html"

	// Upgrade from http request to WebSocket.
    ws, err := gamesocket.Upgrade(this.Ctx.ResponseWriter, this.Ctx.Request)
    if err != nil {
		beego.Error("Cannot setup WebSocket connection:", err)
		return
	}

	// Join chat room.
	sub_id := gamesocket.Join(uname, gamesocket.SUB_WATCH, ws)
	defer gamesocket.Leave(sub_id)

	// Message receive loop.
	for {
        _, _, err := ws.ReadMessage()
        if err != nil {
            beego.Error(err.Error())
			return
		}
    }
}
