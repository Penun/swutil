(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		this.curTab = 1;
		$scope.species = [];
		$scope.curSpec = {};
		$scope.moldSpecies = {};
		$scope.moldTalent = {type: "Passive"};

		angular.element(document).ready(function(){
			$http.get("/species").then(function(ret){
				if (ret.data.success){
					$scope.species = ret.data.result;
				}
			});
		});

		this.AddAbility = function(){
			var abilTxt = document.getElementById("abilAdd");
			var valTxt = abilTxt.value.trim();
			if (valTxt !== ""){
				if (typeof $scope.moldSpecies.attributes === 'undefined' || $scope.moldSpecies.attributes == null){
					$scope.moldSpecies.attributes = [];
				}
				var newAtt = {description: valTxt};
				$scope.moldSpecies.attributes.push(newAtt);
			}
			abilTxt.value = "";
			abilTxt.focus();
		};

		this.AddSpecies = function(){
			var cleared = true;

			if (cleared && (typeof $scope.moldSpecies.attributes === 'undefined' || $scope.moldSpecies.attributes == null || $scope.moldSpecies.attributes.length < 1)){
				cleared = false;
			}

			if (cleared){
				var attributes = $scope.moldSpecies.attributes;
				var species = $scope.moldSpecies;
				delete species.attributes;
				var sendata = {
					species: species,
					attributes: attributes
				};
				$http.post("/species/add", sendata).then(function(ret){
					if (ret.data.success){
						ret.data.species.attributes = ret.data.attributes;
						$scope.species.push(ret.data.species);
						$scope.moldSpecies = {};
						document.getElementById("specName").focus();
					}
				});
			}
		};

		this.AddTalent = function(){
			var sendata = {talent: $scope.moldTalent};
			$http.post("/talents/add", sendata).then(function(ret){
				if (ret.data.success){
					if (typeof $scope.talents === 'undefined'){
						$scope.talents = [ret.data.talent];
					}
					else {
						$scope.talents.push(ret.data.talent);
					}
					$scope.moldTalent = {type: "Passive"};
					document.getElementById("talName").focus();
				}
			});
		};

		this.LoadTab = function(newTab){
			this.curTab = newTab;

			if (newTab == 2){
				if (typeof $scope.talents === 'undefined'){
					$http.get("/talents").then(function(ret){
						if (ret.data.success){
							$scope.talents = ret.data.talents;
						}
					});
				}
			}
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
				this.rotateDeg = ((resY - 100) * 12 / mouseEvent.currentTarget.scrollHeight) + 20;
	 		}
		};
	}]);
})();
