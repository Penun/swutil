{{template "includes/strain/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
            <div ng-show="mCont.ShowStep(1)" class="sixty_he">
                <form id="charAddForm" name="charAddForm" novalidate>
                    <p><label><b>Name:</b></label><input type="text" name="charName" id="charName" ng-model="mCont.char.name" required/></p>
                    <p><label><b>Wound Threshold:</b></label><input type="number" name="cahrWound" ng-model="mCont.char.wound" min="0" required/></p>
                    <p><label><b>Strain Threshold:</b></label><input type="number" name="charStrain" ng-model="mCont.char.strain" min="0" required/></p>
                    <button ng-show="charAddForm.$valid" ng-click="mCont.AddChar()" class="next_butt">Add</button>
                </form>
            </div>
            <div ng-show="mCont.ShowStep(2)" class="sixty_he">
                <p><label><b>{{"{{mCont.char.name}}"}}</b></label></p>
                <p><label><b>W:</b></label> {{"{{mCont.char.wound}}"}}</p>
                <p><label><b>S:</b></label> {{"{{mCont.char.strain}}"}}</p>
            </div>
		</div>
	</div>
</body>
</html>
