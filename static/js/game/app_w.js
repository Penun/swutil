(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.players = [];
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
						if ($scope.players.length == 0){
							$scope.players = ret.data.result;
						} else {
							$scope.players.push(ret.data.result);
						}
						$http.get("/track/status").then(function(ret){
							if (ret.data.success){
								$scope.startInit = ret.data.start_init;
								if ($scope.startInit){
									$scope.curInitInd = ret.data.cur_init_ind;
									$scope.players[$scope.curInitInd].isTurn = true;
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
					for (var i = 0; i < $scope.players.length; i++){
						if ($scope.players[i].player.name == data.player.name){
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
								$scope.players.push(ret.data.live_player);
							}
						});
					}
				} else if (data.player.type == "master") {
					if (data.data !== ""){
						var tPlay = JSON.parse(data.data);
						tPlay.wound = 0;
						tPlay.strain = 0;
						$scope.players.push(tPlay);
						$scope.SortList($scope.players, "initiative");
					}
				}
				break;
			case 1: // LEAVE
				if (data.player.type == "master") {
					if (data.data !== ""){
						var tPlay = JSON.parse(data.data);
						for (var i = 0; i < tPlay.length; i++){
							for (var j = 0; j < $scope.players.length; j++){
								if ($scope.players[j].player.name == tPlay[i].name){
									var setTurn = $scope.players[j].isTurn;
									$scope.players.splice(j, 1);
									if ($scope.players.length == j){
										j--;
									}
									if (setTurn && $scope.players.length > 0) {
										$scope.players[j].isTurn = true;
										$scope.curInitInd = j;
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
					for (var i = 0; i < $scope.players.length; i++){
						if ($scope.players[i].name == data.player.name){
							var setTurn = $scope.players[i].isTurn;
							$scope.players.splice(i, 1);
							if ($scope.players.length == i){
								i--;
							}
							if (setTurn && $scope.players.length > 0) {
								$scope.players[i].isTurn = true;
								$scope.curInitInd = i;
							}
							break;
						}
					}
				}
				$scope.SortList($scope.players, "initiative");
				break;
			case 3: // WOUND
				if (data.player.type != "master"){
					for (var i = 0; i < $scope.players.length; i++){
						if ($scope.players[i].player.name == data.player.name){
							if (typeof $scope.players[i].cur_wound === 'undefined'){
								$scope.players[i].cur_wound = Number(data.data);
							} else {
								$scope.players[i].cur_wound += Number(data.data);
							}
							break;
						}
					}
				} else {
					for (var i = 0; i < data.players.length; i++){
						for (var j = 0; j < $scope.players.length; j++){
							if ($scope.players[j].player.name == data.players[i]){
								$scope.players[j].cur_wound += Number(data.data);
								break;
							}
						}
					}
				}
				break;
			case 4: // STRAIN
				if (data.player.type != "master"){
					for (var i = 0; i < $scope.players.length; i++){
						if ($scope.players[i].player.name == data.player.name){
							if (typeof $scope.players[i].cur_strain === 'undefined'){
								$scope.players[i].cur_strain = Number(data.data);
							} else {
								$scope.players[i].cur_strain += Number(data.data);
							}
							break;
						}
					}
				} else {
					for (var i = 0; i < data.players.length; i++){
						for (var j = 0; j < $scope.players.length; j++){
							if ($scope.players[j].player.name == data.players[i]){
								$scope.players[j].cur_strain += Number(data.data);
								break;
							}
						}
					}
				}
				break;
			case 5: // INITIATIVE
				for (var i = 0; i < $scope.players.length; i++){
					if ($scope.players[i].player.name == data.player.name){
						$scope.players[i].initiative = Number(data.data);
						break;
					}
				}
				$scope.SortList($scope.players, "initiative");
				$scope.ApplyInit();
				break;
			case 6: // INITIATIVE DM RESET
				for (var i = 0; i < data.players.length; i++){
					for (var j = 0; j < $scope.players.length; j++){
						if ($scope.players[j].player.name == data.players[i]){
							$scope.players[j].initiative = 0;
							break;
						}
					}
				}
				$scope.SortList($scope.players, "initiative");
				$scope.ApplyInit();
				break;
			case 7: // Init StartInit
				$scope.startInit = true;
				$scope.players[0].isTurn = true;
				$scope.curInitInd = 0;
				break;
			case 8: // Turn initiative
				if ($scope.startInit){
					$scope.players[$scope.curInitInd].isTurn = false;
					if (data.data === "+"){
						if ($scope.curInitInd == $scope.players.length - 1){
							$scope.curInitInd = 0;
						} else {
							$scope.curInitInd++;
						}
					} else {
						if ($scope.curInitInd == 0){
							$scope.curInitInd = $scope.players.length - 1;
						} else {
							$scope.curInitInd--;
						}
					}
					$scope.players[$scope.curInitInd].isTurn = true;
				}
				break;
			case 9: // End initiative
				$scope.startInit = false;
				$scope.curInitInd = 0;
				for (var i = 0; i < $scope.players.length; i++){
					$scope.players[i].isTurn = false;
				}
				break;
			}
			$scope.$apply();
		};

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

		$scope.ApplyInit = function(){
			if ($scope.startInit){
				for (var i = 0; i < $scope.players.length; i++){
					if ($scope.curInitInd == i){
						$scope.players[i].isTurn = true;
					} else {
						$scope.players[i].isTurn = false;
					}
				}
			}
		};
	}]);
})();
