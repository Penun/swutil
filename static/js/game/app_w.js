(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.gameChars = [];
		$scope.startInit = false;
		$scope.curInitInd = 0;
		$scope.teamLogos = [];

		angular.element(document).ready(function(){
			$scope.sock = new WebSocket('ws://' + $window.location.host + '/track/joinw');
			$timeout($scope.SetupSocket, 30);
		});

		$scope.SetupSocket = function(){
			if ($scope.sock.readyState === 1){
				$scope.sock.onmessage = $scope.HandleMessage;
				$http.get("/track/subs?type=watch").then(function(ret){
					if (ret.data.success){
						for (var i = 0; i < ret.data.result.length; i++){
							ret.data.result.selected = false;
							$scope.gameChars.push(ret.data.result[i]);
						}
					}
					$http.get("/track/logos").then(function(ret){
						if (ret.data.success){
							$scope.teamLogos = ret.data.result;
							if ($scope.gameChars.length > 0){
								for (var i = 0; i < $scope.gameChars.length; i++){
									$scope.gameChars[i].teamDisp = $scope.gameChars[i].initDisp = $scope.AssignTeamLogo($scope.gameChars[i].team);
								}
								$http.get("/track/status").then(function(ret){
									if (ret.data.success){
										$scope.startInit = ret.data.start_init;
										if ($scope.startInit){
											$scope.curInitInd = ret.data.cur_init_ind;
											$scope.SetTurn(true);
										}
									}
								});
							}
						}
					});
				});
			}
		};

		$scope.HandleMessage = function(event){
			var data = JSON.parse(event.data);
			if (data.player.type == 0 && data.data !== ""){
				data.data = JSON.parse(data.data);
			}
			switch (data.type) {
			case 0: // JOIN
				if (data.player.type == 2){
					data.player.initiative = 0;
					var isFound = false;
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].id == data.player.id){
							isFound = true;
							break;
						}
					}
					if (!isFound){
						sendData = {
							id: data.player.id
						}
						$http.post("/track/player", sendData).then(function(ret){
							if (ret.data.success){
								ret.data.live_player.initDisp = ret.data.live_player.teamDisp = $scope.AssignTeamLogo(ret.data.live_player.team);
								ret.data.live_player.selected = false;
								$scope.gameChars.push(ret.data.live_player);
							}
						});
					}
				} else if (data.player.type == 0){
					if (data.data !== ""){
						let tPlay = JSON.parse(data.data.message);
						tPlay.initDisp = tPlay.teamDisp = $scope.AssignTeamLogo(tPlay.team);
						if (typeof tPlay.initiative === 'undefined'){
							tPlay.initiative = 0;
						}
						tPlay.selected = false;
						$scope.gameChars.push(tPlay);
						$scope.SortList($scope.gameChars, "initiative");
						$scope.UpdateCurByIsTurn();
					}
				}
				break;
			case 1: // LEAVE
				if (data.player.type == 0) {
					if (typeof data.data.targets !== 'undefined'){
						for (var i = 0; i < data.data.targets.length; i++){
							for (var j = 0; j < $scope.gameChars.length; j++){
								if ($scope.gameChars[j].id == data.data.targets[i]){
									var setTurn = $scope.gameChars[j].isTurn;
									$scope.gameChars.splice(j, 1);
									if (setTurn){
										$scope.gameChars.length > 0 ? $scope.FindNextInitInd(true, false) : $scope.curInitInd = 0;
										$scope.SetTurn(true);
									}
									break;
								}
							}
						}
					} else {
						$scope.startInit = false;
						$scope.curInitInd = 0;
					}
				} else {
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].id == data.player.id){
							var setTurn = $scope.gameChars[i].isTurn;
							$scope.gameChars.splice(i, 1);
							if (setTurn){
								$scope.gameChars.length > 0 ? $scope.FindNextInitInd(true, false) : $scope.curInitInd = 0;
								$scope.SetTurn(true);
							}
							break;
						}
					}
				}
				$scope.UpdateCurByIsTurn();
				break;
			case 3: // WOUND
				if (data.player.type == 2){
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].id == data.player.id){
							$scope.gameChars[i].cur_wound = typeof $scope.gameChars[i].cur_wound === 'undefined' ? Number(data.data) : $scope.gameChars[i].cur_wound + Number(data.data);
							break;
						}
					}
				} else if (data.player.type == 0){
					for (var i = 0; i < data.data.targets.length; i++){
						for (var j = 0; j < $scope.gameChars.length; j++){
							if ($scope.gameChars[j].id == data.data.targets[i]){
								$scope.gameChars[j].cur_wound += Number(data.data.message);
								break;
							}
						}
					}
				}
				break;
			case 4: // STRAIN
				if (data.player.type == 2){
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].id == data.player.id){
							$scope.gameChars[i].cur_strain = typeof $scope.gameChars[i].cur_strain === 'undefined' ? Number(data.data) : $scope.gameChars[i].cur_strain + Number(data.data)
							break;
						}
					}
				} else if (data.player.type == 0){
					for (var i = 0; i < data.data.targets.length; i++){
						for (var j = 0; j < $scope.gameChars.length; j++){
							if ($scope.gameChars[j].id == data.data.targets[i]){
								$scope.gameChars[j].cur_strain += Number(data.data.message);
								break;
							}
						}
					}
				}
				break;
			case 5: // INITIATIVE
				if (data.player.type == 2){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].id == data.player.id){
							$scope.gameChars[j].initiative = Number(data.data);
							break;
						}
					}
				} else if (data.player.type == 0){
					for (var i = 0; i < data.data.targets.length; i++){
						for (var j = 0; j < $scope.gameChars.length; j++){
							if ($scope.gameChars[j].id ==data.data.targets[i]){
								$scope.gameChars[j].initiative = Number(data.data.message);
								break;
							}
						}
					}
				}
				$scope.SortList($scope.gameChars, "initiative");
				$scope.ApplyInit();
				break;
			case 6:
				break;
			case 7: // Init StartInit
				$scope.startInit = true;
				$scope.FindNextInitInd(true, false);
				$scope.SetTurn(true);
				$scope.HighlightTeam($scope.gameChars[$scope.curInitInd].team);
				break;
			case 8: // Turn initiative
				if ($scope.startInit){
					$scope.SetTurn(false);
					data.data.message === "+" ? $scope.FindNextInitInd(false, false) : $scope.FindNextInitInd(false, true);
					$scope.SetTurn(true);
					$scope.HighlightTeam($scope.gameChars[$scope.curInitInd].team);
				}
				break;
			case 9: // End initiative
				$scope.startInit = false;
				$scope.curInitInd = 0;
				for (var i = 0; i < $scope.gameChars.length; i++){
					$scope.SetTurn(false);
					$scope.curInitInd++;
				}
				$scope.curInitInd = 0;
				$scope.HighlightTeam(0);
				break;
			case 10: // Boost
				var dir = Number(data.data.message);
				for (var i = 0; i < data.data.targets.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].id == data.data.targets[i] && $scope.gameChars[j].cur_boost + dir >= 0){
							$scope.gameChars[j].cur_boost += dir;
							break;
						}
					}
				}
				break;
			case 11: // Setback
				var dir = Number(data.data.message);
				for (var i = 0; i < data.data.targets.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].id == data.data.targets[i] && $scope.gameChars[j].cur_setback + dir >= 0){
							$scope.gameChars[j].cur_setback += dir;
							break;
						}
					}
				}
				break;
			case 12: // Upgrade
				var dir = Number(data.data.message);
				for (var i = 0; i < data.data.targets.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].id == data.data.targets[i] && $scope.gameChars[j].cur_upgrade + dir >= 0){
							$scope.gameChars[j].cur_upgrade += dir;
							break;
						}
					}
				}
				break;
			case 13: // UpDiff
				var dir = Number(data.data.message);
				for (var i = 0; i < data.data.targets.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].id == data.data.targets[i] && $scope.gameChars[j].cur_upDiff + dir >= 0){
							$scope.gameChars[j].cur_upDiff += dir;
							break;
						}
					}
				}
				break;
			case 14: // EVENT_TEAM
				var team = Number(data.data.message);
				for (var i = 0; i < data.data.targets.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].id == data.data.targets[i]){
							$scope.gameChars[j].team = team;
							$scope.gameChars[j].teamDisp = $scope.gameChars[j].initDisp = $scope.AssignTeamLogo(team);
							if ($scope.gameChars[j].team == 0){
								$scope.gameChars[j].initiative = 0;
							}
							break;
						}
					}
				}
				break;
			}
			$scope.$apply();
		};

		$scope.FindNextInitInd = function(incCur, reverse){
			if (!incCur){
				!reverse ? $scope.MoveCurFor() : $scope.MoveCurBack();
			}
			for (var i = 0; i < $scope.gameChars.length; i++){
				if ($scope.gameChars[$scope.curInitInd].initiative > 0){
					return;
				}
				!reverse ? $scope.MoveCurFor() : $scope.MoveCurBack();
			}
		};

		$scope.MoveCurFor = function(){
			$scope.curInitInd == $scope.gameChars.length - 1 ? $scope.curInitInd = 0 : $scope.curInitInd++;
		};

		$scope.MoveCurBack = function(){
			$scope.curInitInd == 0 ? $scope.curInitInd = $scope.gameChars.length - 1 : $scope.curInitInd--;
		};

		$scope.InitDisplayList = function(gameChar){
			return (gameChar.initiative > 0 && gameChar.team > 0);
		}

		$scope.SortList = function(list, varName){
			for (var i = 0; i < list.length; i++){
				var minInd = i;
				for (j = i; j < list.length; ++j){
					if (list[j][varName] > list[minInd][varName]){
						minInd = j;
					}
				}
				if (minInd !== i){
					[list[i], list[minInd]] = [list[minInd], list[i]];
				}
			}
		};

		$scope.UpdateCurByIsTurn = function(){
			if ($scope.startInit){
				for (var i = 0; i < $scope.gameChars.length; i++){
					if ($scope.gameChars[i].isTurn){
						$scope.curInitInd = i;
					}
				}
			}
		};

		$scope.SetTurn = function(isTurn){
			$scope.gameChars[$scope.curInitInd].isTurn = isTurn;
			$scope.gameChars[$scope.curInitInd].initDisp = $scope.AssignTeamLogo($scope.gameChars[$scope.curInitInd].team, isTurn);
		};

		$scope.ApplyInit = function(){
			if ($scope.startInit){
				for (var i = 0; i < $scope.gameChars.length; i++){
					$scope.gameChars[i].isTurn = $scope.curInitInd == i;
				}
			}
		};

		$scope.CalcBoost = function(gameChar){
			var loopArr = [];
			for (var i = 0; i < gameChar.cur_boost; i++){
				loopArr.push(i);
			}
			return loopArr;
		};

		$scope.CalcSetback = function(gameChar){
			var loopArr = [];
			for (var i = 0; i < gameChar.cur_setback; i++){
				loopArr.push(i);
			}
			return loopArr;
		};

		$scope.CalcUpgrade = function(gameChar){
			var loopArr = [];
			for (var i = 0; i < gameChar.cur_upgrade; i++){
				loopArr.push(i);
			}
			return loopArr;
		};

		$scope.CalcUpDiff = function(gameChar){
			var loopArr = [];
			for (var i = 0; i < gameChar.cur_upDiff; i++){
				loopArr.push(i);
			}
			return loopArr;
		};

		$scope.AssignTeamLogo = function(teamId, highlight = false){
			var teamPath = $scope.teamLogos[teamId];
			!highlight ? teamPath += ".png" : teamPath += "_dark.png";
			return teamPath;
		};

		$scope.HighlightTeam = function(teamId){
			for (let i = 0; i < $scope.gameChars.length; i++){
				if (teamId != 0 && $scope.gameChars[i].team == teamId && $scope.gameChars[i].initiative > 0){
					if ($scope.gameChars[i].selected){
						return;
					}
					$scope.gameChars[i].selected = true;
					$scope.gameChars[i].teamDisp = $scope.AssignTeamLogo(teamId, true);
				} else if ($scope.gameChars[i].selected) {
					$scope.gameChars[i].selected = false;
					$scope.gameChars[i].teamDisp = $scope.AssignTeamLogo($scope.gameChars[i].team);
				}
			}
		};
	}]);
})();
