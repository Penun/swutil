{{template "includes/strain/header_w.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
            <div class="sixty_he">
				<ul>
					<li ng-repeat="(ind, play) in players" ng-class="{activePlayer: startInit && play.isTurn, player: !play.isTurn || !startInit }">
                		<span><b>{{"{{play.name}}"}}</b></label></span>
                		<span><b>W:</b></label> {{"{{play.wound}}"}}</span>
                		<span><b>S:</b></label> {{"{{play.strain}}"}}</span>
						<span><b>Init:</b> {{"{{play.initiative}}"}}</span>
					</li>
				</ul>
            </div>
		</div>
	</div>
</body>
</html>
