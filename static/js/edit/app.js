(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		this.curTab = 1;
		$scope.species = [];
		$scope.curSpec = {};
		$scope.moldSpecies = {};

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

			if (typeof $scope.moldSpecies.name === 'undefined' || $scope.moldSpecies.name == null || $scope.moldSpecies.name == ""){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.brawn === 'undefined' || $scope.moldSpecies.brawn == null || $scope.moldSpecies.brawn < 1 || $scope.moldSpecies.brawn > 4)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.agility === 'undefined' || $scope.moldSpecies.agility == null || $scope.moldSpecies.agility < 1 || $scope.moldSpecies.agility > 4)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.intellect === 'undefined' || $scope.moldSpecies.intellect == null || $scope.moldSpecies.intellect < 1 || $scope.moldSpecies.intellect > 4)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.cunning === 'undefined' || $scope.moldSpecies.cunning == null || $scope.moldSpecies.cunning < 1 || $scope.moldSpecies.cunning > 4)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.willpower === 'undefined' || $scope.moldSpecies.willpower == null || $scope.moldSpecies.willpower < 1 || $scope.moldSpecies.willpower > 4)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.presence === 'undefined' || $scope.moldSpecies.presence == null || $scope.moldSpecies.presence < 1 || $scope.moldSpecies.presence > 4)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.wound_threshold === 'undefined' || $scope.moldSpecies.wound_threshold == null || $scope.moldSpecies.wound_threshold > 15 || $scope.moldSpecies.wound_threshold < 6)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.strain_threshold === 'undefined' || $scope.moldSpecies.strain_threshold == null || $scope.moldSpecies.strain_threshold > 15 || $scope.moldSpecies.strain_threshold < 6)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.starting_xp === 'undefined' || $scope.moldSpecies.starting_xp == null || $scope.moldSpecies.starting_xp > 250 || $scope.moldSpecies.starting_xp < 50)){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.ref_page === 'undefined' || $scope.moldSpecies.ref_page == null || $scope.moldSpecies.ref_page == "")){
				cleared = false;
			}
			if (cleared && (typeof $scope.moldSpecies.attributes === 'undefined' || $scope.moldSpecies.attributes == null || $scope.moldSpecies.attributes.length < 1)){
				cleared = false;
			}

			if (cleared){
				var attributes = $scope.moldSpecies.attributes;
				delete $scope.moldSpecies.attributes;
				var sendata = {
					species: $scope.moldSpecies,
					attributes: attributes
				};
				$http.post("/species/add", sendata).then(function(ret){
					if (ret.data.success){
						ret.data.species.attributes = ret.data.attributes;
						$scope.species.push(ret.data.species);
					}
				});
			}
		};

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
				this.rotateDeg = ((resY - 100) * 12 / mouseEvent.currentTarget.scrollHeight) + 20;
	 		}
		};
	}]);
})();
