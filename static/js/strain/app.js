(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		$scope.char = {};
		$scope.curChar = {};
		$scope.note = {};
		this.inpForm = {};
		$scope.backStep = $scope.curStep = 1;
		$scope.textareaReq = true;
		$scope.activeNote = "";
		this.lastNote = 0;
		$scope.charNameSug = "Name";
		this.formInput = "";
		$scope.isTurn = false;
		$scope.audObj = document.createElement("AUDIO");

		this.AddChar = function(){
			$scope.char.name = $scope.char.name.trim();
			if (typeof $scope.char.name === 'undefined' || $scope.char.name.length == 0){
				var charName = document.getElementById("charName");
				charName.focus();
				return;
			}
			if (typeof $scope.char.wound === 'undefined' || $scope.char.wound <= 0){
				$scope.char.wound = null;
				var charWound = document.getElementById("charWound");
				charWound.focus();
				return;
			}
			if (typeof $scope.char.strain === 'undefined' || $scope.char.strain <= 0){
				$scope.char.strain = null;
				var charStrain = document.getElementById("charStrain");
				charStrain.focus();
				return;
			}
			if (typeof $scope.char.brawn === 'undefined' || $scope.char.brawn <= 0){
				$scope.char.brawn = null;
				var charBrawn = document.getElementById("charBrawn");
				charBrawn.focus();
				return;
			}
			if (typeof $scope.char.agility === 'undefined' || $scope.char.agility <= 0){
				$scope.char.agility = null;
				var charAgility = document.getElementById("charAgility");
				charAgility.focus();
				return;
			}
			if (typeof $scope.char.intellect === 'undefined' || $scope.char.intellect <= 0){
				$scope.char.intellect = null;
				var charIntellect = document.getElementById("charIntellect");
				charIntellect.focus();
				return;
			}
			if (typeof $scope.char.cunning === 'undefined' || $scope.char.cunning <= 0){
				$scope.char.cunning = null;
				var charCunning = document.getElementById("charCunning");
				charCunning.focus();
				return;
			}
			if (typeof $scope.char.willpower === 'undefined' || $scope.char.willpower <= 0){
				$scope.char.willpower = null;
				var charWillpower = document.getElementById("charWillpower");
				charWillpower.focus();
				return;
			}
			if (typeof $scope.char.presence === 'undefined' || $scope.char.presence <= 0){
				$scope.char.presence = null;
				var charPresence = document.getElementById("charPresence");
				charPresence.focus();
				return;
			}
			angular.copy($scope.char, $scope.curChar);
			$scope.curChar.initiative = 0;
			$scope.sock = new WebSocket('ws://' + window.location.host + '/track/join?type=play&uname=' + $scope.char.name);
			$timeout($scope.SetupSocket, 150);
		};

		$scope.SetupSocket = function(){
			if ($scope.sock.readyState === 1){
				if ($scope.sock.onmessage == null){
					$scope.sock.onmessage = $scope.HandleMessage;
				}
				$http.get("/track/subs?type=play").then(function(ret){
					if (ret.data.success){
						for (var i = 0; i < ret.data.result.length; i++){
							if (ret.data.result[i].name == $scope.char.name){
								ret.data.result.splice(i, 1);
								break;
							}
						}
						$scope.subs = ret.data.result;
					}
				});
				$scope.SendWound($scope.char.wound);
				$scope.SendStrain($scope.char.strain);
				$scope.SetStep(2, true);
			} else if ($scope.sock.readyState == 3){
				$scope.char = {};
				$scope.sock = null;
				$scope.charNameSug = "Name Taken.";
			}
		};

		$scope.HandleMessage = function(event){
			var data = JSON.parse(event.data);
			switch (data.type) {
				case 0: // JOIN
					if (data.player.type != "watch" && data.player.name != $scope.char.name){
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
				case 4:
					$scope.curChar.wound += Number(data.data);
					break;
				case 5:
					$scope.curChar.strain += Number(data.data);
					break;
				case 6:
					$scope.curChar.initiative = 0;
					break;
				case 7:
				case 8:
					$scope.isTurn = $scope.isTurn ? false : true;
					if ($scope.isTurn && $scope.audObj.paused){
						$scope.audObj.src = "static/snd/alarm.mp3";
						$scope.audObj.play();
					}
					break;
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
			$scope.SetStep(4, false);
			$timeout(function(){
				var inpIn = document.getElementById("inpIn");
				inpIn.focus();
			}, 50);
		};

		this.Input = function(){
			if (typeof this.inpForm.input === 'undefined'){
				var inpIn = document.getElementById("inpIn");
				inpIn.focus();
				return;
			}
			switch(this.formInput){
				case "Initiative":
					this.Initiative();
					break;
			}
		};

		this.Initiative = function(){
			if (this.inpForm.input <= 0){
				this.TargetFormInput();
				return;
			}
			$scope.curChar.initiative = this.inpForm.input;
			$scope.SendInit(this.inpForm.input);
			this.ClearForm();
		};

		this.Wound = function(wnd){
			$scope.curChar.wound += wnd;
			$scope.SendWound(wnd);
		};

		$scope.SendWound = function(wound){
			var sendData = {
				type: "wound",
				data: {
					message: String(wound)
				}
			};
			sendData = JSON.stringify(sendData);
			if ($scope.sock.readyState == 1){
				$scope.sock.send(sendData);
			}
		};

		this.Strain = function(str){
			$scope.curChar.strain += str;
			$scope.SendStrain(str);
		};

		$scope.SendStrain = function(strain){
			var sendData = {
				type: "strain",
				data: {
					message: String(strain)
				}
			};
			sendData = JSON.stringify(sendData);
			if ($scope.sock.readyState == 1){
				$scope.sock.send(sendData);
			}
		};

		$scope.SendInit = function(init){
			var sendData = {
				type: "initiative",
				data: {
					message: String(init)
				}
			};
			sendData = JSON.stringify(sendData);
			if ($scope.sock.readyState == 1){
				$scope.sock.send(sendData);
			}
		};

		this.ClearForm = function(){
			$scope.SetStep($scope.backStep, false);
			this.formInput = "";
			this.inpForm = {};
		};

		this.EndTurn = function(){
			if (!$scope.isTurn){
				return;
			}
			$scope.isTurn = false;
			var sendData = {
				type: "initiative_t",
				data: {
					message: "+"
				}
			};
			sendData = JSON.stringify(sendData);
			if ($scope.sock.readyState == 1){
				$scope.sock.send(sendData);
			}

			if ($scope.audObj.paused){
				var file = Math.floor(Math.random() * 9);
				switch (file){
					case 0:
						$scope.audObj.src = "static/snd/buildingFreakOut.mp3"
						break;
					case 1:
						$scope.audObj.src = "static/snd/curtReply.mp3"
						break;
					case 2:
						$scope.audObj.src = "static/snd/happyThreeChirp.mp3"
						break;
					case 3:
						$scope.audObj.src = "static/snd/pullingTogether.mp3"
						break;
					case 4:
						$scope.audObj.src = "static/snd/shortRaspberry.mp3"
						break;
					case 5:
						$scope.audObj.src = "static/snd/singSongResponse.mp3"
						break;
					case 6:
						$scope.audObj.src = "static/snd/startledWhoop.mp3"
						break;
					case 7:
						$scope.audObj.src = "static/snd/testyBlowup.mp3"
						break;
					case 8:
						$scope.audObj.src = "static/snd/upsetTwoTone.mp3"
						break;
				}

				$scope.audObj.play();
			}
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
