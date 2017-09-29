(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		this.curTab = 1;
		$scope.species = [];
		$scope.curSpec = {};
		$scope.speImg = "";

		angular.element(document).ready(function(){
			$http.get("/species").then(function(ret){
				if (ret.data.success){
					$scope.species = ret.data.result;
				}
			});
		});

		this.RevealSpecies = function(ind){
			if ($scope.species[ind].attributes == null){
				var sendData = {
					"species_id": $scope.species[ind].id,
					"index": ind
				}
				$http.post("/species/attributes", sendData).then(function(ret){
					if (ret.data.success){
						$scope.species[ret.data.index].attributes = ret.data.result;
						$scope.curSpec = $scope.species[ret.data.index];
						$scope.speImg = $scope.curSpec.img_name;
					}
				});
			} else {
				$scope.curSpec = $scope.species[ind];
				$scope.speImg = $scope.curSpec.img_name;
			}
		}

		this.LoadTab = function(newTab){
			this.curTab = newTab;
		};

		this.ShowTab = function(tab_id){
			return this.curTab === tab_id;
		};

		this.SortList = function(varList){
			for (i = 0; i < varList.length; ++i){
				var minInd = i;
				for (j = i; j < varList.length; ++j){
					if (Number(varList[j].init) > Number(varList[minInd].init)){
						minInd = j;
					}
				}
				[varList[i], varList[minInd]] = [varList[minInd], varList[i]];
			}
			return varList;
		};

		this.MoveBook = function(mouseEvent){
			var resY = 0;

		 	if (!mouseEvent){
		   		mouseEvent = window.event;
		 	}

		 	if (mouseEvent.pageY){
		   		resY = mouseEvent.pageY;
		 	} else if (mouseEvent.clientY){
		   		resY = mouseEvent.clientY + document.body.scrollTop + document.documentElement.scrollTop;
		 	}

		 	if (mouseEvent.target){
				this.rotateDeg = ((resY - 100) * 10 / mouseEvent.currentTarget.scrollHeight) + 20;
	 		}
		};
	}]);
})();
