package models

import (
    "github.com/astaxie/beego/orm"
)

func GetAttachments() []Attachment{
    o := orm.NewOrm()
    var atta []Attachment
    o.QueryTable("attachment").OrderBy("type", "name").All(&atta)
    if len(atta) > 0 {
        return atta
    } else {
        return []Attachment{}
    }
}

func AddAttachment(atta Attachment) int64 {
	o := orm.NewOrm()
	id, err := o.Insert(&atta)
	if err == nil {
		return id
	} else {
		return 0
	}
}
