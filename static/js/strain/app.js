(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		this.char = {};
		this.curStep = 1;

		this.AddChar = function(){
			this.char.name = this.char.name.trim();
			this.sock = new WebSocket('ws://' + window.location.host + '/track/join?type=play&uname=' + this.char.name + '&wound=' + this.char.wound + '&strain=' + this.char.strain);
			this.curStep = 2;
		};

		this.Adjust = function(w_s, dir){
			var upda = {
				thresh: w_s,
				direction: dir
			};
			this.sock.send(JSON.stringify(upda));
			var addVal = 0;
			if (dir == 1){
				addVal = 1;
			} else {
				addVal = -1;
			}
			if (w_s == 1){
				this.char.wound += addVal;
			} else {
				this.char.strain += addVal;
			}
		};

		this.ShowStep = function(step){
			return this.curStep == step;
		};
	}]);
})();
