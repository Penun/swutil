(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		this.char = {};
		this.curStep = 1;

		this.AddChar = function(){
			this.sock = new WebSocket('ws://' + window.location.host + '/track/join?type=play&uname=' + this.char.name + '&wound=' + this.char.wound + '&strain=' + this.char.strain);
			this.curStep = 2;
		};

		this.ShowStep = function(step){
			return this.curStep == step;
		};
	}]);
})();
