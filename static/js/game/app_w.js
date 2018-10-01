(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.gameChars = [];
		$scope.startInit = false;
		$scope.curInitInd = 0;

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
							if (ret.data.result[i].type == 'NPCE'){
								ret.data.result[i].initDisplay = "NPC";
							} else {
								ret.data.result[i].initDisplay = "PC";
							}
							$scope.gameChars.push(ret.data.result[i]);
						}
						$http.get("/track/status").then(function(ret){
							if (ret.data.success){
								$scope.startInit = ret.data.start_init;
								if ($scope.startInit){
									$scope.curInitInd = ret.data.cur_init_ind;
									$scope.gameChars[$scope.curInitInd].isTurn = true;
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
								ret.data.live_player.initDisplay = "PC";
								$scope.gameChars.push(ret.data.live_player);
							}
						});
					}
				} else if (data.player.type == "master"){
					if (data.data !== ""){
						var tPlay = JSON.parse(data.data);
						if (tPlay.type == 'NPC'){
							tPlay.initDisplay = "PC";
						} else {
							tPlay.initDisplay = "NPC";
						}
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
					if (data.data !== ""){
						var tPlays = JSON.parse(data.data);
						for (var i = 0; i < tPlays.length; i++){
							for (var j = 0; j < $scope.gameChars.length; j++){
								if ($scope.gameChars[j].player.name == tPlays[i].player.name){
									var setTurn = $scope.gameChars[j].isTurn;
									$scope.gameChars.splice(j, 1);
									if (setTurn){
										if ($scope.gameChars.length > 0) {
											$scope.FindNextInitInd(true, false);
										} else {
											$scope.curInitInd = 0;
										}
										$scope.gameChars[$scope.curInitInd].isTurn = true;
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
								if ($scope.gameChars.length > 0) {
									$scope.FindNextInitInd(true, false);
								} else {
									$scope.curInitInd = 0;
								}
								$scope.gameChars[$scope.curInitInd].isTurn = true;
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
							if (typeof $scope.gameChars[i].cur_wound === 'undefined'){
								$scope.gameChars[i].cur_wound = Number(data.data);
							} else {
								$scope.gameChars[i].cur_wound += Number(data.data);
							}
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
							if (typeof $scope.gameChars[i].cur_strain === 'undefined'){
								$scope.gameChars[i].cur_strain = Number(data.data);
							} else {
								$scope.gameChars[i].cur_strain += Number(data.data);
							}
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
				$scope.gameChars[$scope.curInitInd].isTurn = true;
				break;
			case 8: // Turn initiative
				if ($scope.startInit){
					$scope.gameChars[$scope.curInitInd].isTurn = false;
					if (data.data === "+"){
						$scope.FindNextInitInd(false, false);
					} else {
						$scope.FindNextInitInd(false, true);
					}
					$scope.gameChars[$scope.curInitInd].isTurn = true;
				}
				break;
			case 9: // End initiative
				$scope.startInit = false;
				$scope.curInitInd = 0;
				for (var i = 0; i < $scope.gameChars.length; i++){
					$scope.gameChars[i].isTurn = false;
				}
				break;
			}
			$scope.$apply();
		};

		$scope.FindNextInitInd = function(incCur, reverse){
			if (!incCur){
				if (!reverse){
					$scope.MoveCurFor();
				} else {
					$scope.MoveCurBack();
				}
			}
			for (var i = 0; i < $scope.gameChars.length; i++){
				if ($scope.gameChars[$scope.curInitInd].initiative > 0){
					return;
				}
				if (!reverse){
					$scope.MoveCurFor();
				} else {
					$scope.MoveCurBack();
				}
			}
		};

		$scope.MoveCurFor = function(){
			if ($scope.curInitInd == $scope.gameChars.length - 1){
				$scope.curInitInd = 0;
			} else {
				$scope.curInitInd++;
			}
		};

		$scope.MoveCurBack = function(){
			if ($scope.curInitInd == 0){
				$scope.curInitInd = $scope.gameChars.length - 1;
			} else {
				$scope.curInitInd--;
			}
		};

		$scope.PCDisplayList = function(gameChar){
			if (gameChar.type == 'NPC' || gameChar.type == 'PC'){
				return true;
			} else {
				return false;
			}
		};

		$scope.InitDisplayList = function(gameChar){
			if (gameChar.initiative > 0){
				return true;
			} else {
				return false;
			}
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

		$scope.ApplyInit = function(){
			if ($scope.startInit){
				for (var i = 0; i < $scope.gameChars.length; i++){
					if ($scope.curInitInd == i){
						$scope.gameChars[i].isTurn = true;
					} else {
						$scope.gameChars[i].isTurn = false;
					}
				}
			}
		};
	}]);
})();
