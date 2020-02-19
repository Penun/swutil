package game

func GetPlayerId(playId int) LivePlayer {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId {
				return players[i]
			}
		}
	}
	return LivePlayer{}
}

func WoundPlayer(playId int, wound int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId {
				if players[i].CurWound + wound <= players[i].Character.Wound && players[i].CurWound + wound >= -players[i].Character.Wound * 2 {
					players[i].CurWound += wound
					return
				}
			}
		}
	}
}

func StrainPlayer(playId int, strain int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId {
				if players[i].CurStrain + strain <= players[i].Character.Strain && players[i].CurStrain + strain >= -players[i].Character.Strain * 2 {
					players[i].CurStrain += strain
					return
				}
			}
		}
	}
}

func InitPlayer(playId int, init float64) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId && players[i].Team > 0 {
				players[i].Initiative = init
				return
			}
		}
	}
}

func DeletePlayer(play LivePlayer) {
	if play != (LivePlayer{}) {
		DeletePlayerId(play.Id)
	}
}

func DeletePlayerId(playId int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId {
				RemovePlayer(i)
				return
			}
		}
	}
}

func RemovePlayer(i int) {
	playLen := len(players)
	if i == playLen - 1 {
		players = players[:playLen-1]
	} else {
		players = append(players[:i], players[i+1:]...)
	}
	playLen--
	if curInitInd == i {
		if playLen == 0 {
			curInitInd = 0
		} else {
			FindNextInitInd(true, false)
			players[curInitInd].IsTurn = true
		}
	}
}

func BoostPlayer(playId int, dir int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId && players[i].CurBoost + dir >= 0 {
				players[i].CurBoost += dir
				return
			}
		}
	}
}

func SetbackPlayer(playId int, dir int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId && players[i].CurSetback + dir >= 0 {
				players[i].CurSetback += dir
				return
			}
		}
	}
}

func UpgradePlayer(playId int, dir int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId && players[i].CurUpgrade + dir >= 0 {
				players[i].CurUpgrade += dir
				return
			}
		}
	}
}

func UpDiffPlayer(playId int, dir int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId && players[i].CurUpDiff + dir >= 0 {
				players[i].CurUpDiff += dir
				return
			}
		}
	}
}

func SetPlayTeam(playId int, teamInd int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId {
				players[i].Team = teamInd
				if teamInd == 0 {
					players[i].Initiative = 0
				}
				return
			}
		}
	}
}

func setSubId(playId int, subId int) {
	if playId > 0 {
		for i := 0; i < len(players); i++ {
			if players[i].Id == playId {
				players[i].subId = subId
				return
			}
		}
	}
}

func SortPlayerInit() {
	for  i := 0; i < len(players); i++ {
		minInd := i
		for j := i + 1; j < len(players); j++ {
			if players[j].Initiative > players[minInd].Initiative {
				minInd = j
			}
		}
		if minInd != i {
			swap := players[i]
			players[i] = players[minInd]
			players[minInd] = swap
		}
	}
}

func UpdateCurIndByIsTurn() {
	if initStarted {
		for ind, play := range players {
			if play.IsTurn {
				curInitInd = ind
				break
			}
		}
	}
}

func FindNextInitInd(incCur bool, reverse bool) {
	if !incCur {
		if !reverse {
			MoveCurIndFor()
		} else {
			MoveCurIndBack()
		}
	}
	for i := 0; i < len(players); i++ {
		if players[curInitInd].Initiative > 0 {
			return
		}
		if !reverse {
			MoveCurIndFor()
		} else {
			MoveCurIndBack()
		}
	}
}

func MoveCurIndFor() {
	if curInitInd == len(players) - 1 {
		curInitInd = 0
	} else {
		curInitInd++
	}
}

func MoveCurIndBack() {
	if curInitInd == 0 {
		curInitInd = len(players) - 1
	} else {
		curInitInd--
	}
}
