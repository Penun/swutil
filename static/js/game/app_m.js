(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.gameChars = [];
		$scope.allyVs = [];
		$scope.enemVs = [];
		this.inText = {};
		this.addForm = {};
		this.addAction = "";
		$scope.backStep = $scope.curStep = 3;
		$scope.activeNote = "";
		this.inTextText = "";
		$scope.startInit = false;
		$scope.teamLogos = [];

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
						$scope.gameChars = ret.data.result;
					}
					$http.get("/track/logos").then(function(ret){
						if (ret.data.success){
							$scope.teamLogos = ret.data.result;
							for (var i = 0; i < $scope.gameChars.length; i++){
								$scope.gameChars[i].teamDisp = $scope.AssignTeamLogo($scope.gameChars[i].team);
							}
						}
					});
				});
			}
		};

		$scope.HandleMessage = function(event){
			var data = JSON.parse(event.data);
			switch (data.type) {
				case 0: // JOIN
					if (data.player.type == "play"){
						var isFound = false;
						for (var i = 0; i < $scope.gameChars.length; i++){
							if ($scope.gameChars[i].player.name == data.player.name){
								isFound = true;
								break;
							}
						}
						if (!isFound){
							$scope.gameChars.push({player: data.player, type: "PC"});
							var sendData = {
								name: data.player.name
							};
							$http.post("/track/player", sendData).then(function(ret){
								if (ret.data.success){
									for (var i = 0; i < $scope.gameChars.length; i++){
										if ($scope.gameChars[i].player.name == ret.data.live_player.player.name){
											$scope.gameChars[i] = ret.data.live_player;
											$scope.gameChars[i].teamDisp = $scope.AssignTeamLogo(ret.data.live_player.team);
											break;
										}
									}
								}
							});
						}
					} else {
						if (data.data !== ''){
							data.data = JSON.parse(data.data);
							var newChar = JSON.parse(data.data.message);
							for (var i = $scope.gameChars.length - 1; i >= 0; i--){
								if ($scope.gameChars[i].player.name == newChar.player.name && ($scope.gameChars[i].id == null || typeof $scope.gameChars[i].id === 'undefined')){
									$scope.gameChars[i].id = newChar.id;
									break;
								}
							}
						}
					}
					break;
				case 1: // LEAVE
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].name == data.player.name){
							$scope.gameChars.splice(i, 1);
							break;
						}
					}
					break;
				case 2: // NOTE
					$scope.activeNote += data.player.name + ' says: "' + data.data + '"\n';
					$scope.SetStep(10, false);
					break;
				case 3:
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].player.name == data.player.name){
							$scope.gameChars[i].cur_wound += Number(data.data);
						}
					}
					break;
				case 4:
					for (var i = 0; i < $scope.gameChars.length; i++){
						if ($scope.gameChars[i].player.name == data.player.name){
							$scope.gameChars[i].cur_strain += Number(data.data);
						}
					}
					break;
				case 5:
				for (var i = 0; i < $scope.gameChars.length; i++){
					if ($scope.gameChars[i].player.name == data.player.name){
						$scope.gameChars[i].initiative = Number(data.data);
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
				type: 2, // EVENT_NOTE
				data: {
					targets: this.inText.players,
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
				type: 5, // EVENT_INIT
				data: {
					targets: [],
					message: String(newVal)
				}
			};
			for (var i = 0; i < $scope.gameChars.length; i++){
				if ($scope.gameChars[i].selected && $scope.gameChars[i]. team > 0){
					$scope.gameChars[i].initiative = newVal;
					sendData.data.targets.push($scope.gameChars[i].id);
				}
			}
			if (sendData.data.targets.length > 0){
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
				$scope.initVal = null;
				this.SelectAllChar(true);
			}
		};

		this.SetTeam = function(ind){
			if (ind === null || typeof ind === 'undefined'){
				ind = 0;
			}
			var sendData = {
				type: 14, // EVENT_TEAM
				data: {
					targets: [],
					message: String(ind)
				}
			};
			for (var i = 0; i < $scope.gameChars.length; i++){
				if ($scope.gameChars[i].selected){
					$scope.gameChars[i].team = ind;
					$scope.gameChars[i].teamDisp = $scope.AssignTeamLogo(ind);
					$scope.gameChars[i].selected = false;
					if (ind == 0){
						$scope.gameChars[i].initiative = 0;
					}
					sendData.data.targets.push($scope.gameChars[i].id);
				}
			}
			if (sendData.data.targets.length > 0){
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
			}
			this.teamAction = false;
		};

		this.SetupAdd = function(){
			this.addAction = !this.addAction;
			this.teamAction = false;
		};

		this.SetupTeam = function(){
			this.teamAction = !this.teamAction;
			this.addAction = false;
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
				player: {name: this.addForm.name},
				type: "NPC",
				initiative: 0,
				team: 0,
				teamDisp: "",
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
			$scope.gameChars.push(char);
			sendData = {
				type: 0, // EVENT_JOIN
				data: {
					message: JSON.stringify(char)
				}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
			this.ClearForm(5, false);
		};

		this.SelectChar = function(gameChar){
			for (var i = 0; i < $scope.gameChars.length; i++){
				if ($scope.gameChars[i].id == gameChar.id){
					$scope.gameChars[i].selected = !$scope.gameChars[i].selected;
					if ($scope.gameChars[i].team > 0){
						$scope.gameChars[i].teamDisp = $scope.AssignTeamLogo($scope.gameChars[i].team, $scope.gameChars[i].selected);
					}
				}
			}
		};

		this.SelectAllChar = function(deselect = false){
			if (!deselect){
				for (var i = 0; i < $scope.gameChars.length; i++){
					if ($scope.gameChars[i].selected){
						deselect = true;
						break;
					}
				}
			}
			for (var i = 0; i < $scope.gameChars.length; i++){
				$scope.gameChars[i].selected = !deselect;
				if ($scope.gameChars[i].team > 0){
					$scope.gameChars[i].teamDisp = $scope.AssignTeamLogo($scope.gameChars[i].team, !deselect);
				}
			}
		};

		this.AdjustChar = function(dam, adjType){
			var sendData = {
				data: {
					targets: [],
					message: String(dam)
				}
			};
			for (var i = 0; i < $scope.gameChars.length; i++){
				if ($scope.gameChars[i].selected){
					switch (adjType){
						case "wound":
							adjType = 3;
						case 3: // EVENT_WOUND
							if ($scope.gameChars[i].cur_wound + dam <= $scope.gameChars[i].player.wound && $scope.gameChars[i].cur_wound + dam >= -$scope.gameChars[i].player.wound * 2){
								$scope.gameChars[i].cur_wound += dam;
								sendData.data.targets.push($scope.gameChars[i].id);
							}
							break;
						case "strain":
							adjType = 4;
						case 4: // EVENT_STRAIN
							if (typeof $scope.gameChars[i].cur_strain !== 'undefined' && $scope.gameChars[i].cur_strain !== null && typeof $scope.gameChars[i].player.strain !== 'undefined' && $scope.gameChars[i].player.strain !== null) {
								if ($scope.gameChars[i].cur_strain + dam <= $scope.gameChars[i].player.strain && $scope.gameChars[i].cur_strain + dam >= -$scope.gameChars[i].player.strain * 2){
									$scope.gameChars[i].cur_strain += dam;
									sendData.data.targets.push($scope.gameChars[i].id);
								}
							}
							break;
						case "boost":
							adjType = 10;
						case 10: // EVENT_BOOST
							if ($scope.gameChars[i].cur_boost + dam >= 0){
								$scope.gameChars[i].cur_boost += dam;
								sendData.data.targets.push($scope.gameChars[i].id);
							}
							break;
						case "setback":
							adjType = 11;
						case 11:
							if ($scope.gameChars[i].cur_setback + dam >= 0){
								$scope.gameChars[i].cur_setback += dam;
								sendData.data.targets.push($scope.gameChars[i].id);
							}
							break;
						case "upgrade":
							adjType = 12;
						case 12:
							if ($scope.gameChars[i].cur_upgrade + dam >= 0){
								$scope.gameChars[i].cur_upgrade += dam;
								sendData.data.targets.push($scope.gameChars[i].id);
							}
							break;
						case "upDiff":
							adjType = 13;
						case 13:
							if ($scope.gameChars[i].cur_upDiff + dam >= 0){
								$scope.gameChars[i].cur_upDiff += dam;
								sendData.data.targets.push($scope.gameChars[i].id);
							}
							break;
					}
				}
			}
			if (sendData.data.targets.length > 0){
				sendData.type = adjType;
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
			}
		};

		this.ResetChar = function(){
			var sendData = {
				data: {
					targets: [],
					message: ""
				}
			};
			for (let i = 0; i < $scope.gameChars.length; i++){
				if ($scope.gameChars[i].selected){
					sendData.data.targets.push($scope.gameChars[i].id);
					let sendMess = "";
					if ($scope.gameChars[i].cur_wound != $scope.gameChars[i].player.wound){
						sendData.type = 3; // EVENT_WOUND
						let dam = $scope.gameChars[i].player.wound - $scope.gameChars[i].cur_wound;
						$scope.gameChars[i].cur_wound = $scope.gameChars[i].player.wound;
						sendData.data.message = String(dam);
						sendMess = JSON.stringify(sendData);
						$scope.sock.send(sendMess);
					}
					if ($scope.gameChars[i].cur_strain != $scope.gameChars[i].player.strain){
						sendData.type = 4; // EVENT_STRAIN
						let dam = $scope.gameChars[i].player.strain - $scope.gameChars[i].cur_strain;
						$scope.gameChars[i].cur_strain = $scope.gameChars[i].player.strain;
						sendData.data.message = String(dam);
						sendMess = JSON.stringify(sendData);
						$scope.sock.send(sendMess);
					}
					if ($scope.gameChars[i].initiative > 0){
						$scope.gameChars[i].initiative = 0;
						sendData.type = 5; // EVENT_INIT
						sendData.data.message = "0";
						sendMess = JSON.stringify(sendData);
						$scope.sock.send(sendMess);
					}
					if ($scope.gameChars[i].cur_boost > 0){
						sendData.type = 10; // EVENT_INIT
						sendData.data.message = String(-$scope.gameChars[i].cur_boost);
						sendMess = JSON.stringify(sendData);
						$scope.sock.send(sendMess);
						$scope.gameChars[i].cur_boost = 0;
					}
					if ($scope.gameChars[i].cur_setback > 0){
						sendData.type = 11; // EVENT_INIT
						sendData.data.message = String(-$scope.gameChars[i].cur_setback);
						sendMess = JSON.stringify(sendData);
						$scope.sock.send(sendMess);
						$scope.gameChars[i].cur_setback = 0;
					}
					if ($scope.gameChars[i].cur_upgrade > 0){
						sendData.type = 12; // EVENT_INIT
						sendData.data.message = String(-$scope.gameChars[i].cur_upgrade);
						sendMess = JSON.stringify(sendData);
						$scope.sock.send(sendMess);
						$scope.gameChars[i].cur_upgrade = 0;
					}
					if ($scope.gameChars[i].cur_upDiff > 0){
						sendData.type = 13; // EVENT_INIT
						sendData.data.message = String(-$scope.gameChars[i].cur_upDiff);
						sendMess = JSON.stringify(sendData);
						$scope.sock.send(sendMess);
						$scope.gameChars[i].cur_upDiff = 0;
					}
					sendData.data.targets = [];
				}
			}
		};

		this.DelChar = function(charId){
			for (var i = 0; i < $scope.gameChars.length; i++){
				if ($scope.gameChars[i].id == charId){
					var delChars = [];
					delChars.push($scope.gameChars[i].id);
					sendData = {
						type: 1, // EVENT_LEAVE
						data: {
							targets: delChars
						}
					};
					sendData = JSON.stringify(sendData);
					$scope.sock.send(sendData);
					$scope.gameChars.splice(i, 1);
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
					this.teamAction = false;
					break;
				default:
					return;
			}
		};

		this.ToggleInit = function(){
			if (!$scope.startInit){
				if ($scope.gameChars.length > 0 || $scope.gameChars.length > 0 || $scope.gameChars.length > 0){
					$scope.startInit = true;
					var sendData = {
						type: 7, // EVENT_INIT_S
						data: {}
					};
					sendData = JSON.stringify(sendData);
					$scope.sock.send(sendData);
				}
			} else {
				$scope.startInit = false;
				var sendData = {
					type: 9, // EVENT_INIT_E
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
				type: 8, // EVENT_INIT_T
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
				type: 8, // EVENT_INIT_T
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
	}]);
})();
