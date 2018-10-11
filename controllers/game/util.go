package game

func GetPlayerName(playName string) LivePlayer {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				return players[i]
			}
		}
	}
	return LivePlayer{}
}

func WoundPlayer(playName string, wound int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				if players[i].CurWound + wound <= players[i].Player.Wound && players[i].CurWound + wound >= -players[i].Player.Wound * 2 {
					players[i].CurWound += wound
					break
				}
			}
		}
	}
}

func StrainPlayer(playName string, strain int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				if players[i].CurStrain + strain <= players[i].Player.Strain && players[i].CurStrain + strain >= -players[i].Player.Strain * 2 {
					players[i].CurStrain += strain
					break
				}
			}
		}
	}
}

func InitPlayer(playName string, init float64) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName && players[i].Team > 0 {
				players[i].Initiative = init
				break
			}
		}
	}
}

func DeletePlayer(play LivePlayer) {
	if play != (LivePlayer{}) {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == play.Player.Name {
				RemovePlayer(i)
				break
			}
		}
	}
}

func DeletePlayerName(playName string) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				RemovePlayer(i)
				break
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

func BoostPlayer(playName string, dir int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName && players[i].CurBoost + dir >= 0 {
				players[i].CurBoost += dir
				break
			}
		}
	}
}

func SetbackPlayer(playName string, dir int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName && players[i].CurSetback + dir >= 0 {
				players[i].CurSetback += dir
				break
			}
		}
	}
}

func UpgradePlayer(playName string, dir int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName && players[i].CurUpgrade + dir >= 0 {
				players[i].CurUpgrade += dir
				break
			}
		}
	}
}

func UpDiffPlayer(playName string, dir int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName && players[i].CurUpDiff + dir >= 0 {
				players[i].CurUpDiff += dir
				break
			}
		}
	}
}

func SetPlayTeam(playName string, teamInd int) {
	if playName != "" {
		for i := 0; i < len(players); i++ {
			if players[i].Player.Name == playName {
				players[i].Team = teamInd
				if teamInd == 0 {
					players[i].Initiative = 0
				}
				break
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
