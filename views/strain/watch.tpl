{{template "includes/strain/header_w.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
            <div class="sixty_he">
				<ul>
					<li ng-repeat="(ind, play) in players" ng-class="{activePlayer: startInit && play.isTurn, player: !play.isTurn || !startInit }">
                		<span class="watchSpan"><b>{{"{{play.name}}"}}</b></label></span>
                		<span class="watchSpan"><b>W:</b></label> {{"{{play.wound}}"}}</span>
                		<span class="watchSpan"><b>S:</b></label> {{"{{play.strain}}"}}</span>
						<span class="watchSpan"><b>Init:</b> {{"{{play.initiative}}"}}</span>
					</li>
				</ul>
            </div>
		</div>
	</div>
</body>
</html>
