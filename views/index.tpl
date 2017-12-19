{{template "includes/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain" ng-style="{'transform': 'rotateX('+mCont.rotateDeg+'deg)', '-moz-transform': 'rotateX('+mCont.rotateDeg+'deg)', '-webkit-transform': 'rotateX('+mCont.rotateDeg+'deg)'}">
		<div class="tab_header sw_back" id="tabHeader">
			<span class="tab" ng-click="mCont.LoadTab(1)">Species</span>
			<span class="tab" ng-click="mCont.LoadTab(2)">Careers</span>
			<span class="tab" ng-click="mCont.LoadTab(3)">Weapons</span>
			<span class="tab" ng-click="mCont.LoadTab(4)">Armor</span>
		</div>
		<div class="page sw_back">
			{{template "species.tpl"}}
			{{template "careers.tpl"}}
			{{template "weapons.tpl"}}
			{{template "armor.tpl"}}
		</div>
	</div>
</body>
</html>
