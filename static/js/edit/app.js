(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		this.curTab = 1;
		$scope.species = [];
		$scope.curSpec = {};
		$scope.moldSpecies = {};
		$scope.moldTalent = {type: "Passive"};
		$scope.moldSpecial = {talents: [], skill_slots: 2};

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
				sendata.species.name = species.name.trim();
				sendata.species.ref_page = species.ref_page.trim();
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
			sendata.talent.name = sendata.talent.name.trim();
			sendata.talent.description = sendata.talent.description.trim();
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

		this.AddSpecialization = function(){
			var special = $scope.moldSpecial;
			var careers = special.careers;
			var skills = special.skills;
			var talents = special.talents;
			delete special.careers;
			delete special.skills;
			delete special.talents;

			for (var i = 0; i < talents.length; i++){
				var t_proc = (i + 1) % 4;
				switch(t_proc){
					case 0:
						talents[i].position = 4;
						break;
					default:
						talents[i].position = t_proc;
				}
				talents[i].rank = Math.floor(i / 4) + 1;
			}

			var sendata = {
				specialization: special,
				careers: careers,
				skills: skills,
				talents: talents
			};
			$http.post("/specializations/add", sendata).then(function(ret){
				if (ret.data.success){
					if (typeof $scope.specializations === 'undefined'){
						$scope.specializations = [ret.data.specialization];
					}
					else {
						$scope.specializations.push(ret.data.specialization);
					}
					$scope.moldSpecial = {talents: [], skill_slots: 2};
					document.getElementById("specialName").focus();
				}
			});
		};

		this.CheckSpec = function(){
			if ($scope.moldSpecies.name != ""){
				var found = false;
				for (var i = 0; i < $scope.species.length; i++){
					if ($scope.moldSpecies.name == $scope.species[i].name){
						found = true;
						break;
					}
				}
				this.ApplyInClass(found, "#specName");
			}
		};

		this.CheckTal = function(){
			if ($scope.moldTalent.name != ""){
				var found = false;
				for (var i = 0; i < $scope.talents.length; i++){
					if ($scope.moldTalent.name == $scope.talents[i].name){
						found = true;
						break;
					}
				}
				this.ApplyInClass(found, "#talName");
			}
		};

		this.CheckSpecial = function(){
			if ($scope.moldSpecial.name != ""){
				var found = false;
				for (var i = 0; i < $scope.specializations.length; i++){
					if ($scope.moldSpecial.name == $scope.specializations[i].name){
						found = true;
						break;
					}
				}
				this.ApplyInClass(found, "#specialName");
			}
		};

		this.ApplyInClass = function(found, id){
			var inpNam = angular.element(document.querySelector(id));
			if (found){
				inpNam.addClass("found");
			} else if (inpNam.hasClass("found")) {
				inpNam.removeClass("found");
			}
		};

		this.LoadTab = function(newTab){
			this.curTab = newTab;

			if (newTab == 2){
				if (typeof $scope.talents === 'undefined'){
					this.FetchTalents();
				}
			} else if (newTab == 3){
				if (typeof $scope.careers === 'undefined'){
					$http.get("/careers").then(function(ret){
						if (ret.data.success){
							$scope.careers = ret.data.careers;
						}
					});
				}
				if (typeof $scope.skills === 'undefined'){
					$http.get("/skills").then(function(ret){
						if (ret.data.success){
							$scope.skills = ret.data.skills;
						}
					});
				}
				if (typeof $scope.talents === 'undefined'){
					this.FetchTalents();
				}
				if (typeof $scope.specializations === 'undefined'){
					$http.get("/specializations").then(function(ret){
						if (ret.data.success){
							$scope.specializations = ret.data.specializations;
						}
					});
				}
			}
		};

		this.ShowTab = function(tab_id){
			return this.curTab === tab_id;
		};

		this.FetchTalents = function(){
			$http.get("/talents").then(function(ret){
				if (ret.data.success){
					$scope.talents = ret.data.talents;
				}
			});
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
