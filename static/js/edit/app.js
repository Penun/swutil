(function(){
	var app = angular.module('ddcharL', []);
	app.controller('mainController', ['$window', '$scope', '$http', function($window, $scope, $http){
		this.curTab = 1;
		$scope.species = [];
		$scope.curSpec = {};
		$scope.moldSpecies = {};
		$scope.moldTalent = {type: "Passive"};
		$scope.moldSpecial = {talents: [], skill_slots: 2};
		$scope.moldWeapon = {skill: {}};
		$scope.moldArmor = {};
		$scope.moldGear = {};
		$scope.moldAtta = {};
		$scope.moldDroid = {};
		this.skillsCho = [];
		this.talCho = null;

		angular.element(document).ready(function(){
			$http.get("/species").then(function(ret){
				if (ret.data.occ.success){
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

		this.AddSkills = function(){
			if (typeof $scope.moldDroid.skills === 'undefined'){
				$scope.moldDroid.skills = [];
			}
			for (var i = 0; i < this.skillsCho.length; i++){
				for (var j = 0; j < $scope.skills.length; j++){
					if (this.skillsCho[i] == $scope.skills[j].id){
						var contains = false;
						for (var k = 0; k < $scope.moldDroid.skills.length; k++){
							if ($scope.skills[j].id == $scope.moldDroid.skills[k].skill.id){
								contains = true;
								break;
							}
						}
						if (!contains){
							var ski = {
								"skill": {"id": $scope.skills[j].id},
								"name": $scope.skills[j].name
							};
							$scope.moldDroid.skills.push(ski);
						}
						break;
					}
				}
			}
			this.skillsCho = [];
		};

		this.AddTals = function(){
			if (typeof $scope.moldDroid.talents === 'undefined'){
				$scope.moldDroid.talents = [];
			}
			for (var j = 0; j < $scope.talents.length; j++){
				if (this.talCho == $scope.talents[j].id){
					var contains = false;
					for (var k = 0; k < $scope.moldDroid.talents.length; k++){
						if ($scope.talents[j].id == $scope.moldDroid.talents[k].talent.id){
							contains = true;
							break;
						}
					}
					if (!contains){
						var tal = {
							"talent": {"id": $scope.talents[j].id},
							"name": $scope.talents[j].name
						};
						$scope.moldDroid.talents.push(tal);
					}
					break;
				}
			}
			this.talCho = null;
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
					if (ret.data.occ.success){
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
				if (ret.data.occ.success){
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
				if (ret.data.occ.success){
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

		this.AddWeapon = function(){
			$scope.moldWeapon.skill.id = parseInt($scope.moldWeapon.skill.id);
			var sendData = {
				'weapon': $scope.moldWeapon
			};
			$http.post("/weapons/add", sendData).then(function(ret){
				if (ret.data.occ.success){
					if (typeof $scope.weapons === 'undefined'){
						$scope.weapons = [ret.data.weapon];
					}
					else {
						$scope.weapons.push(ret.data.weapon);
					}
					$scope.moldWeapon = {skill: {}};
					document.getElementById("wepName").focus();
				}
			});
		};

		this.AddArmor = function(){
			var sendData = {
				'armor': $scope.moldArmor
			};
			$http.post("/armor/add", sendData).then(function(ret){
				if (ret.data.occ.success){
					if (typeof $scope.armor === 'undefined'){
						$scope.armor = [ret.data.armor];
					}
					else {
						$scope.armor.push(ret.data.armor);
					}
					$scope.moldArmor = {};
					document.getElementById("armType").focus();
				}
			});
		};

		this.AddGear = function(){
			var sendData = {
				'gear': $scope.moldGear
			};
			$http.post("/gear/add", sendData).then(function(ret){
				if (ret.data.occ.success){
					if (typeof $scope.gear === 'undefined'){
						$scope.gear = [ret.data.gear];
					}
					else {
						$scope.gear.push(ret.data.gear);
					}
					$scope.moldGear = {};
					document.getElementById("gearItem").focus();
				}
			});
		};

		this.AddAtta = function(){
			var sendData = {
				'attachment': $scope.moldAtta
			};
			$http.post("/attachments/add", sendData).then(function(ret){
				if (ret.data.occ.success){
					if (typeof $scope.attachments === 'undefined'){
						$scope.attachments = [ret.data.attachment];
					}
					else {
						$scope.attachments.push(ret.data.attachment);
					}
					$scope.moldAtta = {};
					document.getElementById("attaName").focus();
				}
			});
		};

		this.AddDroid = function(){
			var skis = $scope.moldDroid.skills;
			delete $scope.moldDroid.skills;
			for (var i = 0; i < skis.length; i++){
				delete skis[i].name;
			}
			var tals = $scope.moldDroid.talents;
			delete $scope.moldDroid.talents;
			for (var i = 0; i < tals.length; i++){
				delete tals[i].name;
			}
			var sendData = {
				'droid': $scope.moldDroid,
				'skills': skis,
				'talents': tals
			};
			$http.post("/droids/add", sendData).then(function(ret){
				if (ret.data.occ.success){
					if (typeof $scope.droids === 'undefined'){
						$scope.droids = [ret.data.droid];
					}
					else {
						$scope.droids.push(ret.data.droid);
					}
					$scope.moldDroid = {};
					document.getElementById("droidName").focus();
				}
			});
		};

		this.CheckSpecies = function(){
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

		this.CheckWeapon = function(){
			if ($scope.moldWeapon.name != ""){
				var found = false;
				for (var i = 0; i < $scope.weapons.length; i++){
					if ($scope.moldWeapon.name == $scope.weapons[i].name){
						found = true;
						break;
					}
				}
				this.ApplyInClass(found, "#wepName");
			}
		};

		this.CheckArm = function(){
			if ($scope.moldArmor.type != ""){
				var found = false;
				for (var i = 0; i < $scope.armor.length; i++){
					if ($scope.moldArmor.type == $scope.armor[i].type){
						found = true;
						break;
					}
				}
				this.ApplyInClass(found, "#armType");
			}
		};

		this.CheckGear = function(){
			if ($scope.moldGear.item != ""){
				var found = false;
				for (var i = 0; i < $scope.gear.length; i++){
					if ($scope.moldGear.item == $scope.gear[i].item){
						found = true;
						break;
					}
				}
				this.ApplyInClass(found, "#gearItem");
			}
		};

		this.CheckAtta = function(){
			if ($scope.moldAtta.name != ""){
				var found = false;
				for (var i = 0; i < $scope.attachments.length; i++){
					if ($scope.moldAtta.name == $scope.attachments[i].name){
						found = true;
						break;
					}
				}
				this.ApplyInClass(found, "#attaName");
			}
		};

		this.CheckDroid = function(){
			if ($scope.moldDroid.name != ""){
				var found = false;
				for (var i = 0; i < $scope.droids.length; i++){
					if ($scope.moldDroid.name == $scope.droids[i].name){
						found = true;
						break;
					}
				}
				this.ApplyInClass(found, "#droidName");
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
						if (ret.data.occ.success){
							$scope.careers = ret.data.careers;
						} else {
							$scope.careers = [];
						}
					});
				}
				if (typeof $scope.skills === 'undefined'){
					this.FetchSkills();
				}
				if (typeof $scope.talents === 'undefined'){
					this.FetchTalents();
				}
				if (typeof $scope.specializations === 'undefined'){
					$http.get("/specializations").then(function(ret){
						if (ret.data.occ.success){
							$scope.specializations = ret.data.specializations;
						} else {
							$scope.specializations = [];
						}
					});
				}
			} else if (newTab == 4){
				if (typeof $scope.weapons === 'undefined'){
					$http.get("/weapons").then(function(ret){
						if (ret.data.occ.success){
							$scope.weapons = ret.data.weapons;
						} else {
							$scope.weapons = [];
						}
					});
				}
			} else if (newTab == 5){
				if (typeof $scope.armor === 'undefined'){
					$http.get("/armor").then(function(ret){
						if (ret.data.occ.success){
							$scope.armor = ret.data.armor;
						} else {
							$scope.armor = [];
						}
					});
				}
			} else if (newTab == 6){
				if (typeof $scope.gear === 'undefined'){
					$http.get("/gear").then(function(ret){
						if (ret.data.occ.success){
							$scope.gear = ret.data.gear;
						} else {
							$scope.gear = [];
						}
					});
				}
			} else if (newTab == 7){
				if (typeof $scope.attachments === 'undefined'){
					$http.get("/attachments").then(function(ret){
						if (ret.data.occ.success){
							$scope.attachments = ret.data.attachments;
						} else {
							$scope.attachments = [];
						}
					});
				}
			} else if (newTab == 8){
				if (typeof $scope.droids === 'undefined'){
					$http.get("/droids").then(function(ret){
						if (ret.data.occ.success){
							$scope.droids = ret.data.droids;
						} else {
							$scope.droids = [];
						}
					});
				}
				if (typeof $scope.skills === 'undefined'){
					this.FetchSkills();
				}
				if (typeof $scope.talents === 'undefined'){
					this.FetchTalents();
				}
			}
		};

		this.ShowTab = function(tab_id){
			return this.curTab === tab_id;
		};

		this.FetchTalents = function(){
			$http.get("/talents").then(function(ret){
				if (ret.data.occ.success){
					$scope.talents = ret.data.talents;
				} else {
					$scope.talents = [];
				}
			});
		};

		this.FetchSkills = function(){
			$http.get("/skills").then(function(ret){
				if (ret.data.occ.success){
					$scope.skills = ret.data.skills;
				} else {
					$scope.skills = [];
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
