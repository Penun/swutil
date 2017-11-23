(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.char = {};
		$scope.subs = [];
		this.inText = {};
		this.action = {};
		this.inpForm = {};
		this.addForm = {};
		$scope.enems = [];
		this.delEnem = {};
		$scope.backStep = $scope.curStep = 1;
		this.textareaReq = true;
		$scope.activeNote = "";
		this.actionText = "";
		this.inTextText = "";
		this.inputText = "";
		this.startInit = false;

		angular.element(document).ready(function(){
			$scope.sock = new WebSocket('ws://' + window.location.host + '/track/joinm');
			$timeout($scope.SetupSocket, 30);
		});

		$scope.SetupSocket = function(){
			if ($scope.sock.readyState === 1){
				$scope.sock.onmessage = $scope.HandleMessage;
				$http.get("/track/subs?type=master").then(function(ret){
					if (ret.data.success){
						for (var i = 0; i < ret.data.result.length; i++){
							if (ret.data.result[i].type == "PC"){
								$scope.subs.push(ret.data.result[i]);
							} else if ("NPC") {
								$scope.enems.push(ret.data.result[i]);
							}
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
					$scope.subs.push(data.player);
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

		this.ActionSet = function(act){
			this.actionText = act;
			$scope.SetStep(3, true);
		};

		this.Action = function(){
			if (typeof this.action.players === 'undefined' || this.action.players.length == 0){
				var subSel = document.getElementById("subSelAct");
				subSel.focus();
				return;
			}
			var type = "";
			switch(this.actionText){
				case "Initiative":
					type = "initiative_d";
					break;
				default:
					return;
			}
			var sendData = {
				type: type,
				data: {
					players: this.action.players,
					message: "action"
				}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
			this.ClearForm(3, false);
		};

		this.InputSet = function(inp){
			this.inputText = inp;
			$scope.SetStep(4, true);
		};

		this.Input = function(){
			if (typeof this.inpForm.players === 'undefined' || this.inpForm.players.length == 0){
				var subSel = document.getElementById("subSelInp");
				subSel.focus();
				return;
			}
			if (typeof this.inpForm.input === 'undefined' || this.inpForm.input <= 0){
				var inpIn = document.getElementById("inpIn");
				inpIn.focus();
				return;
			}
			var type = "";
			switch(this.inputText){
				default:
					return;
			}
			var sendData = {
				type: type,
				data: {
					players: this.inpForm.players,
					message: String(this.inpForm.input)
				}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
			this.ClearForm(4, true);
		};

		this.AddEnemy = function(setup){
			if (setup){
				$scope.SetStep(5, false);
			} else {
				var enim = {
					name: this.addForm.name,
					initiative: this.addForm.initiative
				};
				$scope.enems.push(enim);
				sendData = {
					type: "add",
					data: {
						message: JSON.stringify(enim)
					}
				};
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
				this.ClearForm(5, true);
			}
		};

		this.DelEnemy = function(setup){
			if (setup){
				$scope.SetStep(6, false);
			} else {
				if (this.delEnem.enems.length <= 0){
					return;
				}
				var enemPlays = [];
				for (var i = 0; i < this.delEnem.enems.length; i++){
					enemPlays.push({name: this.delEnem.enems[i]});
				}
				sendData = {
					type: "delete",
					data: {
						message: JSON.stringify(enemPlays)
					}
				};
				sendData = JSON.stringify(sendData);
				$scope.sock.send(sendData);
				for (var i = 0; i < this.delEnem.enems.length; i++){
					for (var j = 0; j < $scope.enems.length; j++){
						if ($scope.enems[j].name == this.delEnem.enems[i]){
							$scope.enems.splice(j, 1);
							j--;
						}
					}
				}
				this.ClearForm(6, true);
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
						this.actionText = "";
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
					if (move){
						$scope.SetStep($scope.backStep, false);
					}
					break;
				case 6:
					this.delEnem = {};
					if (move){
						$scope.SetStep($scope.backStep, false);
					}
					break;
				default:
					return;
			}
		};

		this.StartInit = function(){
			if (this.startInit){
				this.startInit = false;
			} else {
				this.startInit = true;
			}
			var sendData = {
				type: "initiative_s",
				data: {}
			};
			sendData = JSON.stringify(sendData);
			$scope.sock.send(sendData);
		};

		this.NextTurn = function(){
			if (!this.startInit){
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
			if (!this.startInit){
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
