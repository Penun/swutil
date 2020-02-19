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

func GetAttachmentRestricted(restricted bool) []Attachment{
    o := orm.NewOrm()
    var atta []Attachment
    o.QueryTable("attachment").Filter("restricted", restricted).All(&atta)
    if len(atta) > 0 {
        return atta
    } else {
        return []Attachment{}
    }
}

func GetAttachmentModificationOptions(id int64) []ModificationOption {
    o := orm.NewOrm()
    var attMods []AttachmentModificationOption
    o.QueryTable("attachment_modification_option").Filter("attachment_id", id).All(&attMods)
    if modLen := len(attMods); modLen > 0 {
        modOpts := make([]ModificationOption, modLen)
        for i := 0; i < modLen; i++ {
            modOpts[i] = GetModificationOption(attMods[i].ModificationOption.Id)
        }
        return modOpts
    } else {
        return []ModificationOption{}
    }
}

func GetAttachmentModels(id int64) []AttachmentModel {
    o := orm.NewOrm()
    var atts []AttachmentModel
    o.QueryTable("attachment_model").Filter("attachment_id", id).All(&atts)
    if len(atts) > 0 {
        return atts
    } else {
        return []AttachmentModel{}
    }
}

func GetModificationOption(id int64) ModificationOption {
    o := orm.NewOrm()
    var modOp ModificationOption
    if err := o.QueryTable("modification_option").Filter("id", id).One(&modOp); err == nil {
        return modOp
    } else {
        return ModificationOption{}
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
