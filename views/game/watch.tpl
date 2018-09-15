{{template "includes/game/header_w.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
            <div class="sixty_he">
				<div class="watchTable">
					<span ng-show="players.length == 0">
						<h2>Waiting../</h2>
					</span>
					<span ng-show="players.length > 0" class="dispPan">
						<span class="sw_back">
							<span class="colHead">
								<span>Allies</span>
							</span>
							<span class="colHead playInner">
								<span>Name</span>
	                    		<span>Wound</span>
	                    		<span>Strain</span>
								<span>Mod</span>
							</span>
						</span>
						<span class="colBod">
							<span ng-repeat="(ind, play) in players" class="playInner listItem">
								<span>{{"{{play.player.name}}"}}</span>
	                    		<span>{{"{{play.cur_wound}}"}}/{{"{{play.player.wound}}"}}</span>
	                    		<span ng-show="play.player.strain > 0">{{"{{play.cur_strain}}"}}/{{"{{play.player.strain}}"}}</span>
								<span></span>
							</span>
						</span>
					</span>
					<span ng-show="players.length > 0" class="rowSp_1_3 waColR dispPan">
						<span class="sw_back">
							<span class="colHead">
								<span>Initiative</span>
							</span>
							<span class="colHead">
								<span>Order</span>
							</span>
						</span>
						<span class="colBod">
							<span ng-repeat="(ind, init) in initOrd" ng-class="{activePlayer: startInit && init.isTurn, player: !init.isTurn || !startInit }" class="listItem">
								<span>{{"{{init.display}}"}}</span>
							</span>
						</span>
					</span>
					<span ng-show="enems.length > 0" class="dispPan">
						<span class="sw_back colSp_1_5">
							<span class="colHead">
								<span>Enemies</span>
							</span>
							<span class="colHead enemInner">
								<span>Name</span>
								<span>Mod</span>
							</span>
						</span>
						<span class="colBod colSp_1_5">
							<span ng-repeat="(ind, enem) in enems" class="enemInner listItem">
								<span>{{"{{enem.player.name}}"}}</span>
								<span></span>
							</span>
						</span>
					</span>
				</div>
            </div>
		</div>
	</div>
</body>
</html>
