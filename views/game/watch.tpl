{{template "includes/game/header_w.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
            <div class="sixty_he">
				<span ng-show="gameChars.length == 0">
					<h2>Waiting../</h2>
				</span>
				<span class="watchTable" ng-show="gameChars.length > 0">
					<span class="dispPan rowSp_1_3">
						<span class="sw_back">
							<span class="colHead">Character Pool</span>
						</span>
						<span class="colBod">
							<span class="dispList">
								<span ng-repeat="(ind, play) in gameChars | orderBy: '-disp_stats'" class="floatItem">
									<span>{{"{{play.player.name}}"}}</span>
									<span>{{str2html rawInitImg}}</span>
									<span class="floatItemStats colSp_1_3" ng-show="play.disp_stats">
	                    				<span>W:{{"{{play.cur_wound}}"}}/{{"{{play.player.wound}}"}}</span>
	                    				<span ng-show="play.player.strain > 0">S:{{"{{play.cur_strain}}"}}/{{"{{play.player.strain}}"}}</span>
									</span>
									<span class="modRow colSp_1_3">
										<img src="/static/img/boost.png" ng-repeat="n in CalcBoost(play)" class="modImg" />
										<img src="/static/img/setBack.png" ng-repeat="n in CalcSetback(play)" class="modImg" />
										<img src="/static/img/triumph.png" ng-repeat="n in CalcUpgrade(play)" class="modImg" />
										<img src="/static/img/dispair.png" ng-repeat="n in CalcUpDiff(play)" class="modImg" />
									</span>
								</span>
							</span>
						</span>
					</span>
					<span class="rowSp_1_3 waColR dispPan">
						<span class="sw_back">
							<span class="colHead">Initiative Order</span>
						</span>
						<span class="colBod initBod">
							<span ng-repeat="(ind, play) in gameChars | filter: InitDisplayList" ng-class="{activePlayer: startInit && play.isTurn}" class="listItem">
								{{str2html rawInitImg}}
							</span>
						</span>
					</span>
				</span>
            </div>
		</div>
	</div>
</body>
</html>
