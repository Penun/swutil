package controllers

import (
    "github.com/Penun/swutil/models"
	"github.com/astaxie/beego"
    //"encoding/json"
    "math/rand"
)

type MarketController struct {
	beego.Controller
}

type MarketList struct {
    MeleeMarket []WeapModel `json:"melee_market"`
    RangedMarket []WeapModel `json:"ranged_market"`
    ArmorMarket []ArmModel `json:"armor_market"`
    GearMarket []GearMod `json:"gear_market"`
    AttachmentMarket []AttModel `json:"attachment_market"`
}

type WeapModel struct {
    Model string `json:"model"`
    Weapon models.Weapon `json:"weapon"`
}

type ArmModel struct {
    Model string `json:"model"`
    Armor models.Armor `json:"armor"`
}

type GearMod struct {
    Model string `json:"model"`
    Gear models.Gear `json:"gear"`
}

type AttModel struct {
    Model string `json:"model"`
    Attachment models.Attachment `json:"attachment"`
}

func (this *MarketController) Get() {
    var marList MarketList
    baseMod := 5
    planetMod := 0
    poolAvg := 4;

    marList.MeleeMarket = GetWeapons("Melee", false, baseMod, planetMod, poolAvg, 2)
    marList.RangedMarket = GetWeapons("Ranged", false, baseMod, planetMod, poolAvg, 3)
    marList.ArmorMarket = GetArmor(false, baseMod, planetMod, poolAvg, 1)
    marList.GearMarket = GetGear(false, baseMod, planetMod, poolAvg, 1)
    marList.AttachmentMarket = GetAttachments(false, baseMod, planetMod, poolAvg, 3)

    this.Data["json"] = marList
	this.ServeJSON()
}

func GetWeapons(weapType string, restricted bool, baseMod, planetMod, poolAvg, countMod int) []WeapModel {
    weapList := models.GetWeaponsByType(weapType, restricted)
    retList := make([]WeapModel, 0)

    for i := 0; i < len(weapList); i++ {
        if weapList[i].Rarity == 0 {
            addWeapon := WeapModel{Model: "", Weapon: weapList[i]}
            addWeapon.Model = GetWeaponModel(weapList[i].Id)
            retList = append(retList, addWeapon)
            weapList = append(weapList[:i], weapList[i+1:]...)
            i--
        }
    }

    curPool := 0;
    poolTot := baseMod * poolAvg * countMod

    for i := 0; i < ((baseMod * countMod) + (planetMod * countMod)); {
        randItem := rand.Intn(len(weapList))
        addWeapon := WeapModel{Model: "", Weapon: weapList[randItem]}
        if addWeapon.Weapon.Rarity == 0 {
            addWeapon.Model = GetWeaponModel(weapList[randItem].Id)
            retList = append(retList, addWeapon)
            i++
        } else {
            if curPool + addWeapon.Weapon.Rarity < poolTot {
                drop := 1 - ((float32(addWeapon.Weapon.Rarity) - 1) * .1) + rand.Float32()
                if  drop > 1 {
                    addWeapon.Model = GetWeaponModel(weapList[randItem].Id)
                    retList = append(retList, addWeapon)
                    i++
                    curPool += addWeapon.Weapon.Rarity
                }
            } else {
                invPool := poolTot - curPool
                deadEnd := true
                for j := 0; j < len(weapList); j++ {
                    if (weapList[j].Rarity < invPool){
                        deadEnd = false
                        break
                    }
                }
                if deadEnd {
                    return retList
                }
            }
        }
    }
    return retList
}

func GetWeaponModel(weap int64) string {
    weapMods := models.GetWeaponModels(weap)
    modLen := len(weapMods)
    if modLen == 1 {
        return weapMods[0].Model
    } else if modLen > 1 {
        randInd := rand.Intn(len(weapMods))
        return weapMods[randInd].Model
    }
    return ""
}

func GetArmor(restricted bool, baseMod, planetMod, poolAvg, countMod int) []ArmModel {
    armList := models.GetArmorRestricted(restricted)
    retList := make([]ArmModel, 0)

    for i := 0; i < len(armList); i++ {
        if armList[i].Rarity == 0 {
            addArmor := ArmModel{Model: "", Armor: armList[i]}
            addArmor.Model = GetArmorModel(armList[i].Id)
            retList = append(retList, addArmor)
            armList = append(armList[:i], armList[i+1:]...)
            i--
        }
    }

    curPool := 0;
    poolTot := baseMod * poolAvg * countMod

    for i := 0; i < ((baseMod * countMod) + (planetMod * countMod)); {
        randItem := rand.Intn(len(armList))
        addArmor := ArmModel{Model: "", Armor: armList[randItem]}
        if addArmor.Armor.Rarity == 0 {
            addArmor.Model = GetArmorModel(armList[randItem].Id)
            retList = append(retList, addArmor)
            i++
        } else {
            if curPool + addArmor.Armor.Rarity < poolTot {
                drop := 1 - ((float32(addArmor.Armor.Rarity) - 1) * .1) + rand.Float32()
                if  drop > 1 {
                    addArmor.Model = GetArmorModel(armList[randItem].Id)
                    retList = append(retList, addArmor)
                    i++
                    curPool += addArmor.Armor.Rarity
                }
            } else {
                invPool := poolTot - curPool
                deadEnd := true
                for j := 0; j < len(armList); j++ {
                    if (armList[j].Rarity < invPool){
                        deadEnd = false
                        break
                    }
                }
                if deadEnd {
                    return retList
                }
            }
        }
    }
    return retList
}

func GetArmorModel(armor int64) string {
    armMods := models.GetArmorModels(armor)
    modLen := len(armMods)
    if modLen == 1 {
        return armMods[0].Model
    } else if modLen > 1 {
        randInd := rand.Intn(len(armMods))
        return armMods[randInd].Model
    }
    return ""
}

func GetGear(restricted bool, baseMod, planetMod, poolAvg, countMod int) []GearMod {
    retList := make([]GearMod, 0)

    if commsBase := baseMod - 2; commsBase > 0 {
        retList = GetGearList(retList, models.GetGearByType("Communications Equipment", restricted), restricted, false, commsBase, planetMod, poolAvg, countMod)
    } else {
        retList = GetGearList(retList, models.GetGearByType("Communications Equipment", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    }
    if drugsBase := baseMod - 2; drugsBase > 0 && !restricted {
        retList = GetGearList(retList, models.GetGearByType("Poisons and Drugs", restricted), restricted, false, drugsBase, planetMod, poolAvg, countMod)
    } else {
        retList = GetGearList(retList, models.GetGearByType("Poisons and Drugs", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    }
    retList = GetGearList(retList, models.GetGearByType("Scanning and Surveillance Equipment (Detection Devices)", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    medBase := baseMod + 2
    retList = GetGearList(retList, models.GetGearByType("Medical Equipment", restricted), restricted, false, medBase, planetMod, poolAvg, countMod)
    if planetMod >= 0 {
        retList = GetGearList(retList, models.GetGearByType("Cybernetic Enhancements and Replacements", restricted), restricted, true, baseMod, planetMod, 10, countMod)
    }
    retList = GetGearList(retList, models.GetGearByType("Recreational Entertainment", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    retList = GetGearList(retList, models.GetGearByType("Infiltration and Espionage Equipment (Security)", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    retList = GetGearList(retList, models.GetGearByType("Survival Gear", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    retList = GetGearList(retList, models.GetGearByType("Tools and Electronics", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod + 1)
    retList = GetGearList(retList, models.GetGearByType("Load Bearing, Carrying, and Storage Equipment", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    retList = GetGearList(retList, models.GetGearByType("Slicing Tools", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    retList = GetGearList(retList, models.GetGearByType("Construction and Salvage Tools", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)
    retList = GetGearList(retList, models.GetGearByType("Remotes", restricted), restricted, false, baseMod, planetMod, poolAvg, countMod)

    return retList
}

func GetGearList(retList []GearMod, gearList []models.Gear, restricted, thinList bool, baseMod, planetMod, poolAvg, countMod int) []GearMod{
    if (len(gearList) <= 0){
        return retList
    }

    curPool := 0;
    poolTot := baseMod * poolAvg * countMod

    for i := 0; i < len(gearList); i++ {
        if gearList[i].Rarity == 0 {
            addGear := GearMod{Model: "", Gear: gearList[i]}
            addGear.Model = GetGearModel(gearList[i].Id)
            retList = append(retList, addGear)
            gearList = append(gearList[:i], gearList[i+1:]...)
            i--
        }
    }

    for i := 0; i < ((baseMod * countMod) + (planetMod * countMod)); {
        randItem := rand.Intn(len(gearList))
        addGear := GearMod{Model: "", Gear: gearList[randItem]}
        if curPool + addGear.Gear.Rarity < poolTot {
            drop := 1 - ((float32(addGear.Gear.Rarity) - 1) * .1) + rand.Float32()
            if  drop > 1 {
                addGear.Model = GetGearModel(gearList[randItem].Id)
                retList = append(retList, addGear)
                i++
                curPool += addGear.Gear.Rarity
                if thinList {
                    gearList = append(gearList[:randItem], gearList[randItem + 1:]...)
                }
            }
        } else {
            invPool := poolTot - curPool
            deadEnd := true
            for j := 0; j < len(gearList); j++ {
                if (gearList[j].Rarity < invPool){
                    deadEnd = false
                    break
                }
            }
            if deadEnd {
                return retList
            }
        }
    }
    return retList
}

func GetGearModel(gear int64) string {
    gearMods := models.GetGearModels(gear)
    modLen := len(gearMods)
    if modLen == 1 {
        return gearMods[0].Model
    } else if modLen > 1 {
        randInd := rand.Intn(len(gearMods))
        return gearMods[randInd].Model
    }
    return ""
}

func GetAttachments(restricted bool, baseMod, planetMod, poolAvg, countMod int) []AttModel {
    attList := models.GetAttachmentRestricted(restricted)
    retList := make([]AttModel, 0)

    for i := 0; i < len(attList); i++ {
        if attList[i].Rarity == 0 {
            addGear := AttModel{Model: "", Attachment: attList[i]}
            addGear.Model = GetAttachmentModel(attList[i].Id)
            retList = append(retList, addGear)
            attList = append(attList[:i], attList[i+1:]...)
            i--
        }
    }

    curPool := 0;
    poolTot := baseMod * poolAvg * countMod

    for i := 0; i < ((baseMod * countMod) + (planetMod * countMod)); {
        randItem := rand.Intn(len(attList))
        addAttach := AttModel{Model: "", Attachment: attList[randItem]}
        if addAttach.Attachment.Rarity == 0 {
            addAttach.Model = GetAttachmentModel(attList[randItem].Id)
            retList = append(retList, addAttach)
            i++
        } else {
            if curPool + addAttach.Attachment.Rarity < poolTot {
                drop := 1 - ((float32(addAttach.Attachment.Rarity) - 1) * .1) + rand.Float32()
                if  drop > 1 {
                    addAttach.Model = GetAttachmentModel(attList[randItem].Id)
                    retList = append(retList, addAttach)
                    i++
                    curPool += addAttach.Attachment.Rarity
                }
            } else {
                invPool := poolTot - curPool
                deadEnd := true
                for j := 0; j < len(attList); j++ {
                    if (attList[j].Rarity < invPool){
                        deadEnd = false
                        break
                    }
                }
                if deadEnd {
                    return retList
                }
            }
        }
    }
    return retList
}

func GetAttachmentModel(attach int64) string {
    attachMods := models.GetAttachmentModels(attach)
    modLen := len(attachMods)
    if modLen == 1 {
        return attachMods[0].Model
    } else if modLen > 1 {
        randInd := rand.Intn(len(attachMods))
        return attachMods[randInd].Model
    }
    return ""
}

func SortWeapList(weapList []WeapModel) []WeapModel {
	for  i := 0; i < len(weapList); i++ {
		minInd := i
		for j := i + 1; j < len(weapList); j++ {
			if weapList[j].Weapon.SubType < weapList[minInd].Weapon.SubType {
				minInd = j
			}
		}
		if minInd != i {
			swap := weapList[i]
			weapList[i] = weapList[minInd]
			weapList[minInd] = swap
		}
	}
    return weapList
}
