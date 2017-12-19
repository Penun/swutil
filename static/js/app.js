(function(){
	var app = angular.module('ddcharL', ['ngSanitize']);
	app.controller('mainController', ['$window', '$scope', '$http', '$timeout', function($window, $scope, $http, $timeout){
		this.curTab = 1;
		$scope.species = [];
		$scope.speImg = "pix.png";
		$scope.talents = [];
		this.rotateDeg = 5;
		$scope.pendCar = null;
		$scope.pendCarSpec = null;
		$scope.pendWeapT = null;
		$scope.pendWeapSub = null;

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
					}
				});
			} else {
				$scope.curSpec = $scope.species[ind];
				$scope.speImg = $scope.curSpec.img_name;
			}
		};

		this.RevealCareer = function(ind){
			if ($scope.curCar != null && $scope.curCar.name == $scope.careers[ind].name){
				return;
			}
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
			this.ToMidCar();
			$scope.curCar = null;
			$scope.pendCar = ind;
			$timeout(this.DelaCar, 10);
			$scope.curSpecial = null;
			$scope.curTale = null;
		};

		this.DelaCar = function(){
			$scope.curCar = $scope.careers[$scope.pendCar];
			$scope.pendCar = null;
		};

		this.RevealSpecialization = function(ind){
			if ($scope.curSpecial != null && $scope.curCar.specializations[ind].name == $scope.curSpecial.name){
				return;
			}
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
			this.ToRightCar();
			$scope.curSpecial = null;
			$scope.pendCarSpec = ind;
			$timeout(this.DelaCarSpec, 10);
			$scope.curTale = null;
		};

		this.DelaCarSpec = function(){
			$scope.curSpecial = $scope.curCar.specializations[$scope.pendCarSpec];
			$scope.pendCarSpec = null;
		};

		this.RevealTalent = function(index){
			$scope.curTale = $scope.talents[index];
			var ele = document.getElementById("right_col");
			ele.scrollTop = ele.scrollHeight;
		};

		this.RevealWeaponType = function(index){
			if ($scope.curWeapType != null && $scope.curWeapType.type_name == $scope.weapons[index].type_name){
				return;
			}
			if ($scope.weapons[index].sub_types == null){
				var sendData = {
					'type': $scope.weapons[index].type_name,
					'index': index
				};
				$http.post("/weapons/sub_types", sendData).then(function(ret){
					if (ret.data.occ.success){
						$scope.weapons[ret.data.index].sub_types = [];
						for (var i = 0; i < ret.data.sub_types.length; i++){
							$scope.weapons[ret.data.index].sub_types.push({
								'type_name': ret.data.sub_types[i].SubType
							});
						}
						$scope.curWeapType = $scope.weapons[ret.data.index];
					}
				});
			}
			this.ToMidWeap();
			$scope.curWeapType = null;
			$scope.pendWeapT = index;
			$timeout(this.DelaWeap, 10);
			$scope.curWeapSub = null;
			$scope.curWeap = null;
		};

		this.DelaWeap = function(){
			$scope.curWeapType = $scope.weapons[$scope.pendWeapT];
			$scope.pendWeapT = null;
		};

		this.RevealWeapons = function(index){
			if ($scope.curWeapSub != null && $scope.curWeapSub.type_name == $scope.curWeapType.sub_types[index].type_name){
				return;
			}
			if ($scope.curWeapType.sub_types[index].weapons == null){
				var sendData = {
					'sub_type': $scope.curWeapType.sub_types[index].type_name,
					'index': index
				};
				$http.post("/weapons/by_sub", sendData).then(function(ret){
					if (ret.data.occ.success){
						$scope.curWeapType.sub_types[ret.data.index].weapons = ret.data.weapons;
						$scope.curWeapSub = $scope.curWeapType.sub_types[ret.data.index];
					}
				});
			}
			this.ToRightWeap();
			$scope.curWeapSub = null;
			$scope.pendWeapSub = index;
			$timeout(this.DelaWeapSub, 10);
			$scope.curWeap = null;
		};

		this.DelaWeapSub = function(){
			$scope.curWeapSub = $scope.curWeapType.sub_types[$scope.pendWeapSub];
			$scope.pendWeapSub = null;
		};

		this.RevealWeapon = function(index){
			$scope.curWeap = $scope.curWeapSub.weapons[index];
			for (var i = 0; i < $scope.skills.length; i++){
				if ($scope.curWeap.skill.id == $scope.skills[i].id){
					$scope.curWeap.skill_ind = i;
					break;
				}
			}
			var ele = document.getElementById("right_col");
			ele.scrollTop = ele.scrollHeight;
		};

		this.RevealArmor = function(ind){
			$scope.curArmor = $scope.armor[ind];
		};

		this.CloseTalent = function(){
			$scope.curTale = null;
		};

		this.CloseWeapon = function(){
			$scope.curWeap = null;
		};

		this.CloseArmor = function(){
			$scope.curArmor = null;
		};

		this.CloseSpecies = function(){
			$scope.curSpec = null;
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
				this.FetchSkills();
			} else if (newTab == 3){
				if (typeof $scope.weapons === 'undefined'){
					$http.get("/weapons/types").then(function(ret){
						if (ret.data.occ.success){
							$scope.weapons = [];
							for (var i = 0; i < ret.data.weapons.length; i++){
								$scope.weapons.push({
									'type_name': ret.data.weapons[i]
								});
							}
						}
					});
				}
				this.FetchSkills();
			} else if  (newTab == 4){
				if (typeof $scope.armor === 'undefined'){
					$http.get("/armor").then(function(ret){
						if (ret.data.occ.success){
							$scope.armor = ret.data.armor;
						}
					});
				}
			}
			this.curTab = newTab;
		};

		this.FetchSkills = function(){
			if (typeof $scope.skills === 'undefined'){
				$http.get("/skills").then(function(ret){
					if(ret.data.occ.success){
						$scope.skills = ret.data.skills;
					}
				});
			}
		};

		this.ShowTab = function(tab_id){
			return this.curTab === tab_id;
		};

		this.SortList = function(list, varName, colC){
			if (this.lastSort != colC + "_" + "d"){
				for (var i = 0; i < list.length; i++){
					var minInd = i;
					for (j = i; j < list.length; ++j){
						if (list[j][varName] > list[minInd][varName]){
							minInd = j;
						}
					}
					[list[i], list[minInd]] = [list[minInd], list[i]];
				}
				this.lastSort = colC + "_" + "d";
			} else {
				for (var i = 0; i < list.length; i++){
					var minInd = i;
					for (j = i; j < list.length; ++j){
						if (list[j][varName] < list[minInd][varName]){
							minInd = j;
						}
					}
					[list[i], list[minInd]] = [list[minInd], list[i]];
				}
				this.lastSort = colC + "_" + "a";
			}
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
				this.rotateDeg = ((resY - 100) * 10 / mouseEvent.currentTarget.scrollHeight) + 5;
	 		}
		};

		this.ToMidCar = function(){
			var midCol = angular.element(document.getElementById("mid_col"));
			midCol.removeClass('unexposed');
			var leftCol = angular.element(document.getElementById("left_col"));
			leftCol.addClass('unexposed');
		};

		this.ToRightCar = function(){
			var rightCol = angular.element(document.getElementById("right_col"));
			rightCol.removeClass('unexposed');
			var midCol = angular.element(document.getElementById("mid_col"));
			midCol.addClass('unexposed');
		};

		this.BackToLeftCar = function(){
			var leftCol = angular.element(document.getElementById("left_col"));
			leftCol.removeClass('unexposed');
			var midCol = angular.element(document.getElementById("mid_col"));
			midCol.addClass('unexposed');
			$scope.curCar = null;
		};

		this.BackToMidCar = function(){
			var midCol = angular.element(document.getElementById("mid_col"));
			midCol.removeClass('unexposed');
			var rightCol = angular.element(document.getElementById("right_col"));
			rightCol.addClass('unexposed');
			$scope.curSpecial = null;
		};

		this.ToMidWeap = function(){
			var midCol = angular.element(document.getElementById("mid_col_w"));
			midCol.removeClass('unexposed');
			var leftCol = angular.element(document.getElementById("left_col_w"));
			leftCol.addClass('unexposed');
		};

		this.ToRightWeap = function(){
			var rightCol = angular.element(document.getElementById("right_col_w"));
			rightCol.removeClass('unexposed');
			var midCol = angular.element(document.getElementById("mid_col_w"));
			midCol.addClass('unexposed');
		};

		this.BackToLeftWeap = function(){
			var leftCol = angular.element(document.getElementById("left_col_w"));
			leftCol.removeClass('unexposed');
			var midCol = angular.element(document.getElementById("mid_col_w"));
			midCol.addClass('unexposed');
			$scope.curWeapType = null;
		};

		this.BackToMidWeap = function(){
			var midCol = angular.element(document.getElementById("mid_col_w"));
			midCol.removeClass('unexposed');
			var rightCol = angular.element(document.getElementById("right_col_w"));
			rightCol.addClass('unexposed');
			$scope.curWeapSub = null;
		};
	}]);
})();
