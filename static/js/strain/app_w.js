(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		$scope.players = [];

		angular.element(document).ready(function(){
			this.sock = new WebSocket('ws://' + $window.location.host + '/track/join?type=watch');
			this.sock.onmessage = function (event) {
		        var data = JSON.parse(event.data);
		        console.log(data);
		        switch (data.Type) {
		        case 0: // JOIN
					if (data.Player.Type == "play"){
		            	$scope.players.push(data.Player);
					}
		            break;
		        case 1: // LEAVE
					for (var i = 0; i < $scope.players.length; i++){
						if ($scope.players[i].Name == data.Player.Name){
							$scope.players.splice(i, 1);
							break;
						}
					}
		            break;
		        case 2: // ADJUST
					for (var i = 0; i < $scope.players.length; i++){
						if ($scope.players[i].Name == data.Player.Name){
							$scope.players[i] = data.Player;
							break;
						}
					}
		            break;
		        }
				$scope.$apply();
		    };
			$http.get("/track/subs").then(function(ret){
				if ($scope.players.length == 0){
					$scope.players = ret.data.Players;
				} else {
					$scope.players.push(ret.data.Players);
				}
			});
		});
	}]);
})();
