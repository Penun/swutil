(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.char = {};
		$scope.playChars = [];
		$scope.charsCurId = 0;
		$scope.allyVs = [];
		$scope.enemVs = [];
		this.inText = {};
		this.action = {};
		this.inpForm = {};
		this.addForm = {};
		this.addAction = "";
		this.damForm = {type: "wound"};
		$scope.backStep = $scope.curStep = 3;
		this.textareaReq = true;
		$scope.activeNote = "";
		this.inTextText = "";
		this.inputText = "";
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
					if (data.player.type == "play" && data.player.name != $scope.char.name){
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

		this.Initiative = function(){
			if (typeof this.action.players === 'undefined' || this.action.players.length == 0){
				var subSel = document.getElementById("subSelAct");
				subSel.focus();
				return;
			}
			var sendData = {
				type: "initiative_d",
				data: {
					players: this.action.players,
					message: "action"
				}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
			this.ClearForm(3, false);
		};

		this.SetupAdd = function(addAction){
			this.addAction = addAction;
		};

		this.AddForm = function(){
			switch (this.addAction){
				case "NPC":
					if (typeof this.addForm.name === 'undefined' || this.addForm.name <= 0){
						var addName = document.getElementById("addNameA");
						addName.focus();
						return;
					}
					if (typeof this.addForm.wound === 'undefined' || this.addForm.wound <= 0){
						var addWound = document.getElementById("addWoundA");
						addWound.focus();
						return;
					}
					break;
				case "NPCE":
					if (typeof this.addForm.name === 'undefined' || this.addForm.name <= 0){
						var addName = document.getElementById("addNameE");
						addName.focus();
						return;
					}
					if (typeof this.addForm.wound === 'undefined' || this.addForm.wound <= 0){
						var addWound = document.getElementById("addWoundE");
						addWound.focus();
						return;
					}
					break;
				default:
					break;
			}
			var char = {
				player: {name: this.addForm.name},
				type: this.addAction,
				id: $scope.charsCurId
			};
			char.player.wound = char.cur_wound = this.addForm.wound;
			if (typeof this.addForm.strain !== 'undefined' || this.addForm.strain > 0){
				char.player.strain = char.cur_strain = this.addForm.strain;
			}
			if (typeof this.addForm.initiative !== 'undefined' || this.addForm.initiative > 0){
				char.initiative = this.addForm.initiative;
			}
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
					if ($scope.playChars[i].selected){
						$scope.playChars[i].selected = false;
					} else {
						$scope.playChars[i].selected = true;
					}
				}
			}
		};

		this.SetupDam = function(damAction){
			this.damAction = damAction;
			switch (this.damAction){
				case "NPCE":
					this.damChars = $scope.playChars;
					break;
				case "NPC":
					this.damChars = $scope.playChars;
					break;
			}
			this.DamForm(true, false);
		};

		this.DamForm = function(setup, takeDam){
			if (setup){
				$scope.SetStep(7, false);
			} else {
				if (this.damForm.chars.length <= 0){
					return;
				}
				if (typeof this.damForm.type === 'undefined'){
					return;
				}
				if (typeof this.damForm.damage === 'undefined' || this.damForm.damage <= 0){
					var damEnemIn = document.getElementById("damEnemIn");
					damEnemIn.focus();
					return;
				}
				var damChars = [];
				switch (this.damAction){
					case "NPCE":
						damChars = $scope.playChars;
						break;
					case "NPC":
						damChars = $scope.playChars;
						break;
				}
				var sendData = {
					type: "",
					data: {
						players: [],
						message: takeDam ? -this.damForm.damage : this.damForm.damage
					}
				};
				for (var i = 0; i < this.damForm.chars.length; i++){
					for (var j = 0; j < damChars.length; j++){
						if (damChars[j].player.name == this.damForm.chars[i]){
							if (this.damForm.type == "wound"){
								sendData.type = "wound";
								if (takeDam){
									damChars[j].cur_wound -= this.damForm.damage;
									sendData.data.players.push(this.damForm.chars[i]);
								} else if (damChars[j].cur_wound + this.damForm.damage <= damChars[j].player.wound){
									damChars[j].cur_wound += this.damForm.damage;
									sendData.data.players.push(this.damForm.chars[i]);
								}
							} else if (typeof damChars[j].player.strain !== 'undefined'){
								sendData.type = "strain";
								if (takeDam){
									damChars[j].cur_strain -= this.damForm.damage;
									sendData.data.players.push(this.damForm.chars[i]);
								} else if (damChars[j].cur_strain + this.damForm.damage <= damChars[j].player.strain){
									damChars[j].cur_strain += this.damForm.damage;
									sendData.data.players.push(this.damForm.chars[i]);
								}
							}
							break;
						}
					}
				}
				sendData.data.message = String(sendData.data.message);
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
				this.ClearForm(7, true);
			}
		};

		this.DelChar = function(charId){
			for (var i = 0; i < $scope.playChars.length; i++){
				if ($scope.playChars[i].id == charId){
					var delChars = [];
					delChars.push({player: $scope.playChars[i].player, type: $scope.playChars[i].type});
					sendData = {
						type: "delete",
						data: {
							message: JSON.stringify(delChars)
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
				case 4:
					this.inpForm = {};
					if (move){
						this.inputText = "";
						$scope.SetStep(1, true);
					}
					break;
				case 5:
					this.addForm = {};
					this.addAction = "";
					if (move){
						$scope.SetStep($scope.backStep, false);
					}
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
