{{template "includes/game/header_w.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
            <div class="sixty_he">
				<span ng-show="gameChars.length == 0">
					<h2>Waiting../</h2>
				</span>
				<div class="watchTable" ng-show="gameChars.length > 0">
					<span class="dispPan">
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
							<span ng-repeat="(ind, play) in gameChars | filter: PCDisplayList | orderBy: '+player.name'" class="playInner listItem">
								<span>{{"{{play.player.name}}"}}</span>
	                    		<span>{{"{{play.cur_wound}}"}}/{{"{{play.player.wound}}"}}</span>
	                    		<span ng-show="play.player.strain > 0">{{"{{play.cur_strain}}"}}/{{"{{play.player.strain}}"}}</span>
								<span class="modCol">
									<img src="/static/img/boost.png" ng-repeat="n in CalcBoost(play)" class="modImg" />
									<img src="/static/img/setBack.png" ng-repeat="n in CalcSetback(play)" class="modImg" />
									<img src="/static/img/triumph.png" ng-repeat="n in CalcUpgrade(play)" class="modImg" />
									<img src="/static/img/dispair.png" ng-repeat="n in CalcUpDiff(play)" class="modImg" />
								</span>
							</span>
						</span>
					</span>
					<span class="rowSp_1_3 waColR dispPan">
						<span class="sw_back">
							<span class="colHead">
								<span>Initiative</span>
							</span>
							<span class="colHead">
								<span>Order</span>
							</span>
						</span>
						<span class="colBod">
							<span ng-repeat="(ind, init) in gameChars | filter: InitDisplayList" ng-class="{activePlayer: startInit && init.isTurn}" class="listItem">
								<span>{{str2html rawInitImg}}</span>
							</span>
						</span>
					</span>
					<span class="dispPan">
						<span class="sw_back colSp_1_5">
							<span class="colHead">
								<span>Enemies</span>
							</span>
							<span class="colHead dualInner">
								<span>Name</span>
								<span>Mod</span>
							</span>
						</span>
						<span class="colBod colSp_1_5">
							<span ng-repeat="(ind, enem) in gameChars | filter:{type: 'NPCE'}:true | orderBy: '+player.name'" class="dualInner listItem">
								<span>{{"{{enem.player.name}}"}}</span>
								<span>
									<img src="/static/img/boost.png" ng-repeat="n in CalcBoost(enem)" class="modImg" />
									<img src="/static/img/setBack.png" ng-repeat="n in CalcSetback(enem)" class="modImg" />
									<img src="/static/img/triumph.png" ng-repeat="n in CalcUpgrade(enem)" class="modImg" />
									<img src="/static/img/dispair.png" ng-repeat="n in CalcUpDiff(enem)" class="modImg" />
								</span>
							</span>
						</span>
					</span>
				</div>
            </div>
		</div>
	</div>
</body>
</html>
