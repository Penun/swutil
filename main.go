package main

import (
	_ "github.com/Penun/swutil/routers"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

func init() {
	orm.RegisterDriver("mysql", orm.DRMySQL)
	dbUser := beego.AppConfig.String("mysqluser")
	dbPass := beego.AppConfig.String("mysqlpass")
	dbInitial := beego.AppConfig.String("mysqldb")
	orm.RegisterDataBase("default", "mysql", dbUser + ":" + dbPass + "@/" + dbInitial + "?charset=utf8")
}

func rawSpecImg() (out string) {
	out = "<img class=\"detail_img\" ng-src=\"/static/img/species/{{speImg}}\" alt=\"\">"
	return
}

func rawInitImg() (out string) {
	out = "<img class=\"initImg\" ng-src=\"/static/img/{{play.dispType}}\" alt=\"\">"
	return
}

func main() {
	orm.Debug = true
	beego.AddFuncMap("rawSpecImg", rawSpecImg)
	beego.AddFuncMap("rawInitImg", rawInitImg)
	beego.Run()
}
