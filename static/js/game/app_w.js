(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.gameChars = [];
		$scope.startInit = false;
		$scope.curInitInd = 0;
		$scope.empLFileName = "empireLogo.png";
		$scope.empDFileName = "empireLogo_dark.png";
		$scope.rebLFileName = "rebelLogo.png";
		$scope.rebDFileName = "rebelLogo_dark.png";

		this.testNum = 4;

		angular.element(document).ready(function(){
			$scope.sock = new WebSocket('ws://' + $window.location.host + '/track/join?type=watch');
			$timeout($scope.SetupSocket, 30);
		});

		$scope.SetupSocket = function(){
			if ($scope.sock.readyState === 1){
				$scope.sock.onmessage = $scope.HandleMessage;
				$http.get("/track/subs?type=watch").then(function(ret){
					if (ret.data.success){
						for (var i = 0; i < ret.data.result.length; i++){
							ret.data.result[i].dispType = (ret.data.result[i].type == 'NPCE') ? $scope.empLFileName : $scope.rebLFileName;
							$scope.gameChars.push(ret.data.result[i]);
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
				});
			}
		};

		$scope.HandleMessage = function(event){
			var data = JSON.parse(event.data);
			switch (data.type) {
			case 0: // JOIN
				if (data.player.type == "play"){
					data.player.initiative = 0;
					var isFound = false;
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].player.name == data.player.name){
							isFound = true;
							break;
						}
					}
					if (!isFound){
						sendData = {
							name: data.player.name
						}
						$http.post("/track/player", sendData).then(function(ret){
							if (ret.data.success){
								ret.data.live_player.dispType = $scope.rebLFileName;
								$scope.gameChars.push(ret.data.live_player);
							}
						});
					}
				} else if (data.player.type == "master"){
					if (data.data !== ""){
						var tPlay = JSON.parse(data.data);
						tPlay.dispType = (tPlay.type == 'NPC') ? tPlay.dispType = $scope.rebLFileName : $scope.empLFileName;
						if (typeof tPlay.initiative === 'undefined'){
							tPlay.initiative = 0;
						}
						$scope.gameChars.push(tPlay);
						$scope.SortList($scope.gameChars, "initiative");
						$scope.UpdateCurByIsTurn();
					}
				}
				break;
			case 1: // LEAVE
				if (data.player.type == "master") {
					if (data.players !== ""){
						for (var i = 0; i < data.players.length; i++){
							for (var j = 0; j < $scope.gameChars.length; j++){
								if ($scope.gameChars[j].player.name == data.players[i]){
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
						if ($scope.gameChars[i].name == data.player.name){
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
				if (data.player.type != "master"){
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].player.name == data.player.name){
							$scope.gameChars[i].cur_wound = typeof $scope.gameChars[i].cur_wound === 'undefined' ? Number(data.data) : $scope.gameChars[i].cur_wound + Number(data.data);
							break;
						}
					}
				} else {
					for (var i = 0; i < data.players.length; i++){
						for (var j = 0; j < $scope.gameChars.length; j++){
							if ($scope.gameChars[j].player.name == data.players[i]){
								$scope.gameChars[j].cur_wound += Number(data.data);
								break;
							}
						}
					}
				}
				break;
			case 4: // STRAIN
				if (data.player.type != "master"){
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].player.name == data.player.name){
							$scope.gameChars[i].cur_strain = typeof $scope.gameChars[i].cur_strain === 'undefined' ? Number(data.data) : $scope.gameChars[i].cur_strain + Number(data.data)
							break;
						}
					}
				} else {
					for (var i = 0; i < data.players.length; i++){
						for (var j = 0; j < $scope.gameChars.length; j++){
							if ($scope.gameChars[j].player.name == data.players[i]){
								$scope.gameChars[j].cur_strain += Number(data.data);
								break;
							}
						}
					}
				}
				break;
			case 5: // INITIATIVE
				for (var i = 0; i < data.players.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].player.name == data.players[i]){
							$scope.gameChars[j].initiative = Number(data.data);
							break;
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
				break;
			case 8: // Turn initiative
				if ($scope.startInit){
					$scope.SetTurn(false);
					data.data === "+" ? $scope.FindNextInitInd(false, false) : $scope.FindNextInitInd(false, true);
					$scope.SetTurn(true);
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
				break;
			case 10: // Boost
				var dir = Number(data.data);
				for (var i = 0; i < data.players.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].player.name == data.players[i] && $scope.gameChars[j].cur_boost + dir >= 0){
							$scope.gameChars[j].cur_boost += dir;
						}
					}
				}
				break;
			case 11: // Setback
				var dir = Number(data.data);
				for (var i = 0; i < data.players.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].player.name == data.players[i] && $scope.gameChars[j].cur_setback + dir >= 0){
							$scope.gameChars[j].cur_setback += dir;
						}
					}
				}
				break;
			case 12: // Upgrade
				var dir = Number(data.data);
				for (var i = 0; i < data.players.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].player.name == data.players[i] && $scope.gameChars[j].cur_upgrade + dir >= 0){
							$scope.gameChars[j].cur_upgrade += dir;
						}
					}
				}
					break;
			case 13: // UpDiff
				var dir = Number(data.data);
				for (var i = 0; i < data.players.length; i++){
					for (var j = 0; j < $scope.gameChars.length; j++){
						if ($scope.gameChars[j].player.name == data.players[i] && $scope.gameChars[j].cur_upDiff + dir >= 0){
							$scope.gameChars[j].cur_upDiff += dir;
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

		$scope.PCDisplayList = function(gameChar){
			return gameChar.type == 'NPC' || gameChar.type == 'PC';
		};

		$scope.InitDisplayList = function(gameChar){
			return gameChar.initiative > 0;
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
			if (isTurn){
				$scope.gameChars[$scope.curInitInd].dispType = $scope.gameChars[$scope.curInitInd].type == 'NPCE' ? $scope.empDFileName : $scope.rebDFileName;
			} else {
				$scope.gameChars[$scope.curInitInd].dispType = $scope.gameChars[$scope.curInitInd].type == 'NPCE' ? $scope.empLFileName : $scope.rebLFileName;
			}
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
	}]);
})();
