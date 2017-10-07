(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		this.curTab = 1;
		$scope.species = [];
		$scope.speImg = "";
		$scope.talents = [];

		angular.element(document).ready(function(){
			$http.get("/species").then(function(ret){
				if (ret.data.occ.success){
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
					if (ret.data.occ.success){
						$scope.species[ret.data.index].attributes = ret.data.result;
						$scope.curSpec = $scope.species[ret.data.index];
						$scope.speImg = $scope.curSpec.img_name;
						angular.element(document.querySelector("#specRight")).addClass("fade_in");
					}
				});
			} else {
				$scope.curSpec = $scope.species[ind];
				$scope.speImg = $scope.curSpec.img_name;
				angular.element(document.querySelector("#specRight")).addClass("fade_in");
			}
		};

		this.RevealCareer = function(ind){
			if ($scope.careers[ind].specializations == null){
				var sendData = {
					"career_id": $scope.careers[ind].id,
					"index": ind
				};
				$http.post("/careers/specializations", sendData).then(function(ret){
					if (ret.data.occ.success){
						$scope.careers[ret.data.index].specializations = ret.data.result;
					}
				});
			}
			if ($scope.careers[ind].skills == null){
				var sendData = {
					"career_id": $scope.careers[ind].id,
					"index": ind
				};
				$http.post("/careers/skills", sendData).then(function(ret){
					if (ret.data.occ.success){
						var cSkill = [];
						for (var i = 0; i < ret.data.result.length; i++){
							for (var j = 0; j < $scope.skills.length; j++){
								if ($scope.skills[j].id == ret.data.result[i].skill.id){
									cSkill.push(j);
									break;
								}
							}
						}
						$scope.careers[ret.data.index].skills = cSkill;
					}
				});
			}
			$scope.curSpecial = null;
			$scope.curTale = null;
			$scope.curCar = $scope.careers[ind];
		};

		this.RevealSpecialization = function(ind){
			if ($scope.curCar.specializations[ind].talents == null){
				var sendData = {
					"specialization_id": $scope.curCar.specializations[ind].id,
					"index": ind
				}
				$http.post("/specializations/talents", sendData).then(function(ret){
					if (ret.data.occ.success){
						$scope.curCar.specializations[ret.data.index].talents = [];
						for (var i = 0; i < ret.data.result.length; i++){
							var tale = ret.data.result[i];
							var found = false;
							for (var j = 0; j < $scope.talents.length; j++){
								if ($scope.talents[j].id == tale.talent.id){
									found = true;
									tale.index = j;
									break;
								}
							}
							if (!found){
								$scope.talents.push(tale.talent);
								tale.index = $scope.talents.length - 1;
							}
							if (tale.right){
								tale.disp_right = {'visibility': 'visible'};
							} else {
								tale.disp_right = {'visibility': 'hidden'};
							}
							if (tale.down){
								tale.disp_down = {'visibility': 'visible'};
							} else {
								tale.disp_down = {'visibility': 'hidden'};
							}
							delete tale.right;
							delete tale.down;
							delete tale.talent;
							delete tale.specialization;
							delete tale.id;
							$scope.curCar.specializations[ret.data.index].talents[i] = tale;
 						}
					}
				});
			}
			if ($scope.curCar.specializations[ind].skills == null){
				var sendData = {
					"specialization_id": $scope.curCar.specializations[ind].id,
					"index": ind
				};
				$http.post("/specializations/skills", sendData).then(function(ret){
					if (ret.data.occ.success){
						var cSkill = [];
						for (var i = 0; i < ret.data.result.length; i++){
							for (var j = 0; j < $scope.skills.length; j++){
								if ($scope.skills[j].id == ret.data.result[i].skill.id){
									cSkill.push(j);
									break;
								}
							}
						}
						$scope.curCar.specializations[ret.data.index].skills = cSkill;
					}
				});
			}
			$scope.curSpecial = $scope.curCar.specializations[ind];
			$scope.curTale = null;
		};

		this.RevealTalent = function(index){
			$scope.curTale = $scope.talents[index];
			var ele = document.getElementById("right_col");
			ele.scrollTop = ele.scrollHeight;
		};

		this.CloseTalent = function(){
			$scope.curTale = null;
		};

		this.LoadTab = function(newTab){
			if (newTab == 2){
				if (typeof $scope.careers === 'undefined'){
					$http.get("/careers").then(function(ret){
						if (ret.data.occ.success){
							$scope.careers = ret.data.careers;
						}
					});
				}
				if (typeof $scope.skill === 'undefined'){
					$http.get("/skills").then(function(ret){
						if(ret.data.occ.success){
							$scope.skills = ret.data.skills;
						}
					});
				}
			}
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
