(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.char = {};
		$scope.curChar = {};
		$scope.note = {};
		$scope.backStep = $scope.curStep = 1;
		$scope.textareaReq = true;
		$scope.activeNote = "";
		this.lastNote = 0;
		$scope.charNameSug = "Name";
		this.formInput = "";
		$scope.audObj = document.createElement("AUDIO");
		$scope.playSugs = [];
		this.lastPlayFind = "";
		$scope.initStarted = false;

		angular.element(document).ready(function(){
			$http.get("/track/check").then(function(ret){
				if (ret.data.success){
					$scope.curChar = ret.data.live_player.player;
					$scope.curChar.curWound = ret.data.live_player.cur_wound;
					$scope.curChar.curStrain = ret.data.live_player.cur_strain;
					$scope.curChar.initiative = ret.data.live_player.initiative;
					$scope.sock = new WebSocket('ws://' + window.location.host + '/track/join?type=play&uname=' + $scope.curChar.name);
					$timeout($scope.SetupSocket, 500);
				}
			});
		});

		this.FindPlayer = function(){
			var primed = false;
			if (typeof $scope.char.name === 'undefined'){
				return;
			}
			if ($scope.char.name.length < 3){
				$scope.playSugs = [];
				return;
			} else if ($scope.char.name.length == 3){
				if (this.lastPlayFind.length <= $scope.char.name.length){
					primed = true;
				}
			} else if (this.lastPlayFind.length > $scope.char.name.length && $scope.playSugs.length > 0){
				primed = true;
			}
			var newSugs = [];
			for (var i = 0; i < $scope.playSugs.length; i++){
				if ($scope.playSugs[i].name == $scope.char.name){
					return;
				}
				if ($scope.playSugs[i].name.length > $scope.char.name.length){
					var subN = $scope.playSugs[i].name.slice(0, $scope.char.name.length);
					if (subN.localeCompare($scope.char.name) == 0){
						newSugs.push($scope.playSugs[i]);
					}
				}
			}
			this.lastPlayFind = $scope.char.name;
			if (newSugs.length > 0){
				$scope.playSugs = newSugs;
				return;
			}
			if (primed){
				var sendData = {
					name: $scope.char.name
				};
				$http.post("/track/find", sendData).then(function(ret){
					if (ret.data.success){
						$scope.playSugs = ret.data.players;
					}
				});
			}
		};

		this.AddChar = function(){
			$scope.char.name = $scope.char.name.trim();
			if (typeof $scope.char.name === 'undefined' || $scope.char.name.length == 0){
				var charName = document.getElementById("charName");
				charName.focus();
				return;
			}
			for (var i = 0; i < $scope.playSugs.length; i++){
				if ($scope.char.name == $scope.playSugs[i].name){
					angular.copy($scope.playSugs[i], $scope.curChar);
				}
			}
			if (typeof $scope.curChar.wound === 'undefined'){
				var sendData = {
					name: $scope.char.name
				};
				$http.post("/track/verify", sendData).then(function(ret){
					if (ret.data.success){
						$scope.curChar = ret.data.player;
						$scope.BridgeToSetup();
					} else {
						$scope.char.name = "";
						$scope.charNameSug = "Name Not Found";
					}
				});
			} else {
				$scope.BridgeToSetup();
			}
		};

		$scope.BridgeToSetup = function(){
			$scope.curChar.curWound = $scope.curChar.wound;
			$scope.curChar.curStrain = $scope.curChar.strain;
			$scope.curChar.initiative = 0;
			$scope.sock = new WebSocket('ws://' + window.location.host + '/track/join?type=play&uname=' + $scope.curChar.name);
			$timeout($scope.SetupSocket, 500);
		}

		$scope.SetupSocket = function(){
			if ($scope.sock.readyState === 1){
				if ($scope.sock.onmessage == null){
					$scope.sock.onmessage = $scope.HandleMessage;
				}
				$http.get("/track/subs?type=play").then(function(ret){
					if (ret.data.success){
						for (var i = 0; i < ret.data.result.length; i++){
							if (ret.data.result[i].player.name == $scope.curChar.name){
								ret.data.result.splice(i, 1);
								break;
							}
						}
						$scope.subs = ret.data.result;
					}
				});
				$http.get("/track/status").then(function(ret){
					if (ret.data.success){
						$scope.initStarted = ret.data.start_init;
					}
				});
				$scope.SetStep(2, true);
			} else if ($scope.sock.readyState == 3){
				$scope.curChar = {};
				$scope.sock = null;
				$scope.charNameSug = "Error/Refresh";
			}
		};

		$scope.HandleMessage = function(event){
			var data = JSON.parse(event.data);
			switch (data.type) {
				case 0: // JOIN
					if (data.player.type != "watch" && data.player.name != $scope.curChar.name){
						var isFound = false;
						for (var i = 0; i < $scope.subs.length; i++){
							if ($scope.subs[i].player.name == data.player.name){
								isFound = true;
								break;
							}
						}
						if (!isFound){
							$scope.subs.push({player: data.player});
						}
					}
					break;
				case 1: // LEAVE
					for (var i = 0; i < $scope.subs.length; i++){
						if ($scope.subs[i].name == data.player.name){
							$scope.subs.splice(i, 1);
							break;
						}
					}
					break;
				case 2: // NOTE
					$scope.activeNote += data.player.name + ' says: "' + data.data + '"\n';
					$scope.SetStep(10, false);
					break;
				case 3: //Wound
					$scope.curChar.curWound += Number(data.data);
					break;
				case 4: //strain
					$scope.curChar.curStrain += Number(data.data);
					break;
				case 5:
					$scope.curChar.initiative = Number(data.data);
					break;
				case 7:
					$scope.initStarted = true;
					break;
				case 9:
					$scope.initStarted = false;
					break;
				case 6:
				case 8:
				default:
					return;
			}
			$scope.$apply();
		};

		this.SendNote = function(){
			var calcedT = (Date.now() - this.lastNote) / 900000;
			if (calcedT < 1){
				$scope.activeNote = 'DM says: "Only one note every 15 minutes."\n';
				$scope.SetStep(10, false);
				return;
			}
			if (typeof $scope.note.players === 'undefined' || $scope.note.players.length == 0){
				var subSel = document.getElementById("subSel");
				subSel.focus();
				return;
			}
			if (typeof $scope.note.message === 'undefined' || $scope.note.message.length == 0){
				var noteMessage = document.getElementById("noteMessage");
				noteMessage.focus();
				return;
			}

			var sendData = {
				type: "note",
				data: {
					players: $scope.note.players,
					message: $scope.note.message
				}
			};
			sendData = JSON.stringify(sendData);
			if ($scope.sock.readyState == 1){
				$scope.sock.send(sendData);
			}
			this.lastNote = Date.now();
			$scope.note = {};
			$scope.SetStep(2, true);
		};

		this.ReadNote = function(){
			$scope.activeNote = "";
			$scope.SetStep($scope.backStep, false);
		};

		this.InputSet = function(inp){
			this.formInput = inp;
			this.TargetFormInput();
		};

		this.TargetFormInput = function(){
			var inpIn = document.getElementById("inpIn");
			inpIn.focus();
		};

		this.Initiative = function(newInit){
			if ($scope.initStarted){
				return;
			}
			if (newInit == null){
				this.TargetFormInput();
				return;
			}
			$scope.curChar.initiative = newInit;
			var sendData = {
				type: "initiative",
				data: {
					players: [$scope.curChar.name],
					message: String(newInit)
				}
			};
			if ($scope.sock.readyState == 1){
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
				this.ClearForm();
			}
		};

		this.Wound = function(wnd){
			if ($scope.curChar.curWound + wnd <= $scope.curChar.wound && $scope.curChar.curWound + wnd >= -$scope.curChar.wound * 2){
				$scope.curChar.curWound += wnd;
				var sendData = {
					type: "wound",
					data: {
						message: String(wnd)
					}
				};
				sendData = JSON.stringify(sendData);
				if ($scope.sock.readyState == 1){
					$scope.sock.send(sendData);
				}
			}
		};

		this.Strain = function(str){
			if ($scope.curChar.curStrain + str <= $scope.curChar.strain && $scope.curChar.curStrain + str >= -$scope.curChar.strain * 2){
				$scope.curChar.curStrain += str;
				var sendData = {
					type: "strain",
					data: {
						message: String(str)
					}
				};
				sendData = JSON.stringify(sendData);
				if ($scope.sock.readyState == 1){
					$scope.sock.send(sendData);
				}
			}
		};

		this.ClearForm = function(){
			$scope.SetStep($scope.backStep, false);
			this.formInput = "";
			$scope.inpIn = null;
		};

		this.ShowStep = function(step){
			return $scope.curStep == step;
		};

		$scope.SetStep = function(step, upBack){
			$scope.curStep = step;
			if (upBack){
				$scope.backStep = step;
			}
		};
	}]);
})();
