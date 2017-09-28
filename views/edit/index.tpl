{{template "includes/edit/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="headDiv" id="headDiv">

	</div>
	<div class="mainDiv" id="forwardMain" ng-mousemove="mCont.MoveBook($event)" ng-style="{'transform': 'rotateX('+mCont.rotateDeg+'deg)', '-moz-transform': 'rotateX('+mCont.rotateDeg+'deg)', '-webkit-transform': 'rotateX('+mCont.rotateDeg+'deg)'}">
		<div class="tab_header sw_back" id="tabHeader">
			<span class="tab" ng-click="mCont.LoadTab(1)">Species</span>
			<span class="tab" ng-click="mCont.LoadTab(2)">Talents</span>
			<span class="tab" ng-click="mCont.LoadTab(3)">Specializations</span>
		</div>
		<div class="page sw_back">
			{{template "edit/species.tpl"}}
			{{template "edit/talents.tpl"}}
			{{template "edit/specializations.tpl"}}
		</div>
	</div>
</body>
</html>
