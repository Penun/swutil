{{template "includes/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="headDiv" id="headDiv">

	</div>
	<div class="mainDiv sw_back" id="forwardMain" ng-mousemove="mCont.MoveBook($event)" ng-style="{'transform': 'rotateX('+mCont.rotateDeg+'deg)', '-moz-transform': 'rotateX('+mCont.rotateDeg+'deg)', '-webkit-transform': 'rotateX('+mCont.rotateDeg+'deg)'}">
		<div class="page">
			<div class="tab_header">
				<span class="tab" ng-click="mCont.LoadTab(1)">Species</span>
				<span class="tab" ng-click="mCont.LoadTab(2)">Careers</span>
			</div>
			{{template "species.tpl"}}
			{{template "careers.tpl"}}
		</div>
	</div>
</body>
</html>
