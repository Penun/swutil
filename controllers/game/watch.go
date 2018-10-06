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
	gamesocket.Join(uname, "watch", ws)
	defer gamesocket.Leave(uname)

	// Message receive loop.
	for {
        _, _, err := ws.ReadMessage()
        if err != nil {
			return
		}
    }
}
