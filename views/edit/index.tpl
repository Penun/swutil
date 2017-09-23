{{template "includes/edit/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="headDiv" id="headDiv">

	</div>
	<div class="mainDiv" id="forwardMain" ng-mousemove="mCont.MoveBook($event)" ng-style="{'transform': 'rotateX('+mCont.rotateDeg+'deg)', '-moz-transform': 'rotateX('+mCont.rotateDeg+'deg)', '-webkit-transform': 'rotateX('+mCont.rotateDeg+'deg)'}">
		<div class="page">
			<div ng-click="mCont.LoadTab(1)">Species</div>
			<div ng-click="mCont.LoadTab(2)">Talents</div>
			<div ng-click="mCont.LoadTab(3)">Specializations</div>
			{{template "edit/species.tpl"}}
			{{template "edit/talents.tpl"}}
			{{template "edit/specializations.tpl"}}
		</div>
	</div>
</body>
</html>
