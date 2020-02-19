{{template "includes/edit/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain" ng-mousemove="mCont.MoveBook($event)" ng-style="{'transform': 'rotateX('+mCont.rotateDeg+'deg)', '-moz-transform': 'rotateX('+mCont.rotateDeg+'deg)', '-webkit-transform': 'rotateX('+mCont.rotateDeg+'deg)'}">
		<div class="tab_header sw_back" id="tabHeader">
			<!-- <span class="tab" ng-click="mCont.LoadTab(1)">Species</span>
			<span class="tab" ng-click="mCont.LoadTab(2)">Talents</span>
			<span class="tab" ng-click="mCont.LoadTab(3)">Specializations</span> -->
			<span class="tab" ng-click="mCont.LoadTab(4)">Weapons</span>
			<span class="tab" ng-click="mCont.LoadTab(5)">Armor</span>
			<span class="tab" ng-click="mCont.LoadTab(6)">Gear</span>
			<span class="tab" ng-click="mCont.LoadTab(7)">Attachments</span>
			<!-- <span class="tab" ng-click="mCont.LoadTab(8)">Droids</span>
			<span class="tab" ng-click="mCont.LoadTab(9)">Vehicles</span>
			<span class="tab" ng-click="mCont.LoadTab(10)">Starships</span>
			<span class="tab" ng-click="mCont.LoadTab(11)">Players</span> -->
		</div>
		<div class="page sw_back">
			{{template "edit/weapons.tpl"}}
			{{template "edit/armor.tpl"}}
			{{template "edit/gear.tpl"}}
			{{template "edit/attachments.tpl"}}
		</div>
	</div>
</body>
</html>
