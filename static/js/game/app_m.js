(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.playChars = [];
		$scope.charsCurId = 0;
		$scope.allyVs = [];
		$scope.enemVs = [];
		this.inText = {};
		this.addForm = {};
		this.addAction = "";
		$scope.backStep = $scope.curStep = 3;
		$scope.activeNote = "";
		this.inTextText = "";
		$scope.startInit = false;

		angular.element(document).ready(function(){
			$http.get("/track/status").then(function(ret){
				if (ret.data.success){
					$scope.startInit = ret.data.start_init;
				}
			});
			$scope.sock = new WebSocket('ws://' + window.location.host + '/track/joinm');
			$timeout($scope.SetupSocket, 30);
		});

		$scope.SetupSocket = function(){
			if ($scope.sock.readyState === 1){
				$scope.sock.onmessage = $scope.HandleMessage;
				$http.get("/track/subs?type=master").then(function(ret){
					if (ret.data.success){
						for (var i = 0; i < ret.data.result.length; i++){
							ret.data.result[i].id = $scope.charsCurId;
							$scope.playChars.push(ret.data.result[i]);
							$scope.charsCurId++;
						}
					}
				});
			}
		};

		$scope.HandleMessage = function(event){
			var data = JSON.parse(event.data);
			switch (data.type) {
				case 0: // JOIN
					if (data.player.type == "play"){
						var isFound = false;
						for (var i = 0; i < $scope.playChars.length; i++){
							if ($scope.playChars[i].player.name == data.player.name){
								isFound = true;
								break;
							}
						}
						if (!isFound){
							$scope.playChars.push({player: data.player, type: "PC", id: $scope.charsCurId});
							$scope.charsCurId++;
							var sendData = {
								name: data.player.name
							};
							$http.post("/track/player", sendData).then(function(ret){
								if (ret.data.success){
									for (var i = 0; i < $scope.playChars.length; i++){
										if ($scope.playChars[i].player.name == ret.data.live_player.player.name){
											$scope.playChars[i].cur_wound = ret.data.live_player.cur_wound;
											$scope.playChars[i].cur_strain = ret.data.live_player.cur_strain;
											$scope.playChars[i].cur_boost = ret.data.live_player.cur_boost;
											$scope.playChars[i].cur_setback = ret.data.live_player.cur_setback;
											$scope.playChars[i].cur_upgrade = ret.data.live_player.cur_upgrade;
											$scope.playChars[i].cur_upDiff = ret.data.live_player.cur_upDiff;
											$scope.playChars[i].player.wound = ret.data.live_player.player.wound;
											$scope.playChars[i].player.strain = ret.data.live_player.player.strain;
											$scope.playChars[i].initiative = ret.data.live_player.initiative;
											break;
										}
									}
								}
							});
						}
					}
					break;
				case 1: // LEAVE
					for (var i = 0; i < $scope.playChars.length; i++){
						if ($scope.playChars[i].name == data.player.name){
							$scope.playChars.splice(i, 1);
							break;
						}
					}
					break;
				case 2: // NOTE
					$scope.activeNote += data.player.name + ' says: "' + data.data + '"\n';
					$scope.SetStep(10, false);
					break;
				case 3:
					for (var i = 0; i < $scope.playChars.length; i++){
						if ($scope.playChars[i].player.name == data.player.name){
							$scope.playChars[i].cur_wound += Number(data.data);
						}
					}
					break;
				case 4:
					for (var i = 0; i < $scope.playChars.length; i++){
						if ($scope.playChars[i].player.name == data.player.name){
							$scope.playChars[i].cur_strain += Number(data.data);
						}
					}
					break;
				case 5:
				for (var i = 0; i < $scope.playChars.length; i++){
					if ($scope.playChars[i].player.name == data.player.name){
						$scope.playChars[i].initiative = Number(data.data);
					}
				}
					break;
				default:
					return;
			}
			$scope.$apply();
		};

		this.ReadNote = function(){
			$scope.activeNote = "";
			$scope.SetStep($scope.backStep, false);
		};

		this.InTextSet = function(inT){
			this.inTextText = inT;
			$scope.SetStep(2, true);
		};

		this.InText = function(){
			if (typeof this.inText.players === 'undefined' || this.inText.players.length == 0){
				var subSel = document.getElementById("subSelInText");
				subSel.focus();
				return;
			}
			if (typeof this.inText.message === 'undefined' || this.inText.message.length == 0){
				var inTextMessage = document.getElementById("inTextMessage");
				inTextMessage.focus();
				return;
			}
			var type = "";
			switch(this.inTextText){
				case "Note":
					type = "note";
					break;
				default:
					return;
			}
			var sendData = {
				type: "note",
				data: {
					players: this.inText.players,
					message: this.inText.message
				}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
			this.ClearForm(2, true);
		};

		this.Initiative = function(newVal){
			if (newVal === null || typeof newVal === 'undefined'){
				newVal = 0;
			}
			var sendData = {
				type: "initiative",
				data: {
					players: [],
					message: String(newVal)
				}
			};
			var found = false;
			for (var i = 0; i < $scope.playChars.length; i++){
				if ($scope.playChars[i].selected){
					$scope.playChars[i].initiative = newVal;
					sendData.data.players.push($scope.playChars[i].player.name);
					if (!found){
						found = true;
					}
				}
			}
			if (found){
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
				$scope.initVal = null;
				this.SelectPlayerChar(true, "ALL");
			}
		};

		this.SetupAdd = function(){
			this.addAction = true;
		};

		this.AddForm = function(){
			if (!this.addAction){
				return;
			}
			if (typeof this.addForm.name === 'undefined' || this.addForm.name <= 0){
				var addName = document.getElementById("addName");
				addName.focus();
				return;
			}
			if (typeof this.addForm.wound === 'undefined' || this.addForm.wound <= 0){
				var addWound = document.getElementById("addWound");
				addWound.focus();
				return;
			}
			var char = {
				id: $scope.charsCurId,
				player: {name: this.addForm.name},
				type: "NPC",
				disp_stats: this.addForm.dispStats,
				cur_boost: 0,
				cur_setback: 0,
				cur_upgrade: 0,
				cur_upDiff: 0
			};
			char.player.wound = char.cur_wound = this.addForm.wound;
			if (typeof this.addForm.strain !== 'undefined' || this.addForm.strain > 0){
				char.player.strain = char.cur_strain = this.addForm.strain;
			}
			char.initiative = typeof this.addForm.initiative !== 'undefined' || this.addForm.initiative > 0 ? this.addForm.initiative : 0;
			$scope.playChars.push(char);
			$scope.charsCurId++;
			sendData = {
				type: "add",
				data: {
					message: JSON.stringify(char)
				}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
			this.ClearForm(5, false);
		};

		this.SelectChar = function(gameChar){
			for (var i = 0; i < $scope.playChars.length; i++){
				if ($scope.playChars[i].id == gameChar.id){
					$scope.playChars[i].selected = !$scope.playChars[i].selected;
				}
			}
		};

		this.SelectPlayerChar = function(deselect = false, targType = "ALL"){
			if (!deselect){
				for (var i = 0; i < $scope.playChars.length; i++){
					if ($scope.playChars[i].selected && ($scope.playChars[i].type == targType || targType == "ALL")){
						deselect = true;
						break;
					}
				}
			}
			for (var i = 0; i < $scope.playChars.length; i++){
				if ($scope.playChars[i].type == targType || targType == "ALL"){
					$scope.playChars[i].selected = !deselect;
				}
			}
		};

		this.AdjustChar = function(dam, adjType){
			var sendData = {
				type: adjType,
				data: {
					players: [],
					message: String(dam)
				}
			};
			var found = false;
			for (var i = 0; i < $scope.playChars.length; i++){
				if ($scope.playChars[i].selected){
					switch (adjType){
						case "wound":
							if ($scope.playChars[i].cur_wound + dam <= $scope.playChars[i].player.wound && $scope.playChars[i].cur_wound + dam >= -$scope.playChars[i].player.wound * 2){
								$scope.playChars[i].cur_wound += dam;
								sendData.data.players.push($scope.playChars[i].player.name);
								if (!found){
									found = true;
								}
							}
							break;
						case "strain":
							if (typeof $scope.playChars[i].cur_strain !== 'undefined' && $scope.playChars[i].cur_strain !== null && typeof $scope.playChars[i].player.strain !== 'undefined' && $scope.playChars[i].player.strain !== null) {
								if ($scope.playChars[i].cur_strain + dam <= $scope.playChars[i].player.strain && $scope.playChars[i].cur_strain + dam >= -$scope.playChars[i].player.strain * 2){
									$scope.playChars[i].cur_strain += dam;
									sendData.data.players.push($scope.playChars[i].player.name);
									if (!found){
										found = true;
									}
								}
							}
							break;
						case "boost":
							if ($scope.playChars[i].cur_boost + dam >= 0){
								$scope.playChars[i].cur_boost += dam;
								sendData.data.players.push($scope.playChars[i].player.name);
								if (!found){
									found = true;
								}
							}
							break;
						case "setback":
							if ($scope.playChars[i].cur_setback + dam >= 0){
								$scope.playChars[i].cur_setback += dam;
								sendData.data.players.push($scope.playChars[i].player.name);
								if (!found){
									found = true;
								}
							}
							break;
						case "upgrade":
							if ($scope.playChars[i].cur_upgrade + dam >= 0){
								$scope.playChars[i].cur_upgrade += dam;
								sendData.data.players.push($scope.playChars[i].player.name);
								if (!found){
									found = true;
								}
							}
							break;
						case "upDiff":
							if ($scope.playChars[i].cur_upDiff + dam >= 0){
								$scope.playChars[i].cur_upDiff += dam;
								sendData.data.players.push($scope.playChars[i].player.name);
								if (!found){
									found = true;
								}
							}
							break;
					}
				}
			}
			if (found){
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
			}
		};

		this.DelChar = function(charId){
			for (var i = 0; i < $scope.playChars.length; i++){
				if ($scope.playChars[i].id == charId){
					var delChars = [];
					delChars.push($scope.playChars[i].player.name);
					sendData = {
						type: "delete",
						data: {
							players: delChars
						}
					};
					sendData = JSON.stringify(sendData);
					$scope.sock.send(sendData);
					$scope.playChars.splice(i, 1);
					break;
				}
			}
		};

		this.ClearForm = function(form, move){
			switch(form){
				case 2:
					this.inText = {};
					if (move){
						this.inTextText = "";
						$scope.SetStep(1, true);
					}
					break;
				case 3:
					this.action = {};
					if (move){
						$scope.SetStep(1, true);
					}
					break;
				case 5:
					this.addForm = {};
					this.addAction = false;
					break;
				case 6:
					this.delForm = {};
					if (move){
						$scope.SetStep($scope.backStep, false);
					}
					break;
				case 7:
					this.damForm = {type: "wound"};
					this.damAction = "";
					if (move){
						$scope.SetStep($scope.backStep, false);
					}
					break;
				default:
					return;
			}
		};

		this.ToggleInit = function(){
			if (!$scope.startInit){
				if ($scope.playChars.length > 0 || $scope.playChars.length > 0 || $scope.playChars.length > 0){
					$scope.startInit = true;
					var sendData = {
						type: "initiative_s",
						data: {}
					};
					sendData = JSON.stringify(sendData);
					$scope.sock.send(sendData);
				}
			} else {
				$scope.startInit = false;
				var sendData = {
					type: "initiative_e",
					data: {}
				};
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
			}
		};

		this.NextTurn = function(){
			if (!$scope.startInit){
				return;
			}
			var sendData = {
				type: "initiative_t",
				data: {
					message: "+"
				}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
		};

		this.PrevTurn = function(){
			if (!$scope.startInit){
				return;
			}
			var sendData = {
				type: "initiative_t",
				data: {
					message: "-"
				}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
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
