{{template "includes/game/header_m.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
			<div ng-show="mCont.ShowStep(10)" class="sixty_he">
				<span class="masterGrid">
					<span class="masterGridInner charDispBod">
						{{"{{activeNote}}"}}
					</span>
					<span class="menu menuText" ng-click="mCont.ReadNote()">Read</span>
				</span>
			</div>
            <div ng-show="mCont.ShowStep(1)" class="sixty_he">
				<ul>
					<li class="clickable" ng-click="mCont.InTextSet('Note')">Note</li>
					<li class="clickable" ng-click="SetStep(3, true)">Initiative</li>
				</ul>
            </div>
			<div ng-show="mCont.ShowStep(2)" class="sixty_he">
				<button class="menu_p" ng-click="mCont.ClearForm(2, true)">Menu</button>
				<form name="inTextForm" id="inTextForm" novalidate>
					<p class="s_ws_p_inline"><label for="subSelInText"><b>Players:</b></label></p>
					<select name="subSelInText" id="subSelInText" ng-show="subs.length > 0" ng-model="mCont.inText.players" ng-options="sub.player.name as sub.player.name for sub in subs" multiple required></select>
					<p class="s_ws_p_inline"><label for="inTextMessage"><b>{{"{{mCont.inTextText}}"}}:</b></label></p>
					<textarea name="inTextMessage" id="inTextMessage" ng-model="mCont.inText.message" ng-required="mCont.textareaReq"></textarea>
					<button ng-show="inTextForm.$valid" ng-click="mCont.InText()">Send</button>
				</form>
			</div>
			<div ng-show="mCont.ShowStep(3)" class="sixty_he">
				<span class="masterGrid">
					<span class="menu mainMenuButton">
						<span class="menuInner" ng-click="mCont.ClearForm(3, true)"></span>
					</span>
					<span id="characterDisp">
						<span class="sw_back">
							<span class="charAltHead">
								<span class="clickHead" ng-click="mCont.SelectPlayerChar()">Character Pool</span>
								<span class="menu menuText" ng-click="mCont.SetupAdd()">+</span>
							</span>
						</span>
						<span class="charDispBod">
							<span class="dispList hold1x1">
								<span ng-repeat="(ind, play) in playChars | orderBy: '+disp_stats'" class="dispItem itemBord" ng-class="{selectedItem: play.selected}" ng-click="mCont.SelectChar(play)">
									<span class="dispItemName">{{"{{play.player.name}}"}}</span>
									<span class="menu menuText menuBordT menuBordR dispItemClose" ng-click="mCont.DelChar(play.id)">X</span>
									<span class="menuColSpan dispItemStats">
										<span>W:{{"{{play.cur_wound}}"}}/{{"{{play.player.wound}}"}}</span>
										<span ng-show="play.player.strain > 0" class="dispItemStr">S:{{"{{play.cur_strain}}"}}/{{"{{play.player.strain}}"}}</span>
										<span ng-show="play.initiative > 0" class="dispItemInit">I:{{"{{play.initiative}}"}}</span>
									</span>
									<span class="menuColSpan modRow">
										<img src="/static/img/boost.png" ng-repeat="n in CalcBoost(play)" class="modImg" />
										<img src="/static/img/setBack.png" ng-repeat="n in CalcSetback(play)" class="modImg" />
										<img src="/static/img/triumph.png" ng-repeat="n in CalcUpgrade(play)" class="modImg" />
										<img src="/static/img/dispair.png" ng-repeat="n in CalcUpDiff(play)" class="modImg" />
									</span>
								</span>
							</span>
							<span ng-show="mCont.addAction" class="formWrapper hold1x1 itemBord">
								<span class="menu menuText formButt" ng-click="mCont.ClearForm(5, false)">Cancel</span>
								<form name="addCharForm" id="addCharForm" class="formInner" novalidate>
									<span class="flexItem"><span>Show Stats:</span><span class="inputBack"><input type="checkbox" name="dispStats" id="dispStats" class="inputBod" ng-model="mCont.addForm.dispStats" /></span></span>
									<span class="flexItem"><span>Name:</span><span class="inputBack"><input type="text" name="addName" id="addName" class="inputBod" ng-model="mCont.addForm.name" placeholder="Name" required/></span></span>
									<span class="flexItem"><span>Wound:</span><span class="inputBack"><input type="number" name="addWound" id="addWound" class="inputBod" ng-model="mCont.addForm.wound" placeholder="0" required/></span></span>
									<span class="flexItem"><span>Strain:</span><span class="inputBack"><input type="number" name="addStrain" id="addStrain" class="inputBod" ng-model="mCont.addForm.strain" placeholder="0" /></span></span>
									<span class="flexItem"><span>Initiative:</span><span class="inputBack"><input type="number" name="addInit" id="addInit" class="inputBod" ng-model="mCont.addForm.initiative" step="any" placeholder="0" /></span></span>
									<input ng-disabled="!addCharForm.$valid" ng-click="mCont.AddForm()" type="submit" />
								</form>
								<span ng-show="addCharForm.$valid" ng-click="mCont.AddForm()" class="menu menuText formButt">Add</span>
							</span>
						</span>
					</span>
					<span id="characterMenu" ng-show="playChars.length > 0">
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Wound</span>
							</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(-1, 'wound')">-</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(1, 'wound')">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Strain</span>
							</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(-1, 'strain')">-</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(1, 'strain')">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Boost</span>
							</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(-1, 'boost')">-</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(1, 'boost')">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Setback</span>
							</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(-1, 'setback')">-</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(1, 'setback')">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Upgrade</span>
							</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(-1, 'upgrade')">-</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(1, 'upgrade')">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Up Diff</span>
							</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(-1, 'upDiff')">-</span>
							<span class="menu menuText" ng-click="mCont.AdjustChar(1, 'upDiff')">+</span>
						</span>
					</span>
					<span id="initiativeDisp" class="charDispBod">
						<span ng-show="!startInit && (playChars.length > 0)" class="initBlock">
							<form name="setInitForm" id="setInitForm" novalidate>
								<span class="flexItem"><span>Initiative:</span><span class="inputBack"><input type="number" name="initVal" id="initVal" ng-model="initVal" class="inputBod" placeholder="0" required/></span></span>
								<input ng-click="mCont.Initiative(initVal)" type="submit" />
							</form>
							<span class="menu menuText" ng-show="setInitForm.$valid" ng-click="mCont.Initiative(initVal)">Set</span>
							<span class="menu menuText" ng-show="!setInitForm.$valid" ng-click="mCont.Initiative()">Reset</span>
						</span>
						<span ng-show="startInit">Initiative running....</span>
					</span>
					<span id="initiativeMenu" class="menuTitledBlock">
						<span class="menu menuBordT menuText menuColSpan" ng-show="playChars.length > 0" ng-click="mCont.ToggleInit()">{{"{{startInit ? \"End\" : \"Start\"}}"}}</span>
						<span class="menu menuText" ng-show="startInit" ng-click="mCont.PrevTurn()"><</span>
						<span class="menu menuText" ng-show="startInit" ng-click="mCont.NextTurn()">></span>
					</span>
					<!-- <span id="vehicleDisp">
						<span class="menuColSpan sw_back">
							<span class="menuColSpan">Vehicles</span>
							<span>Allies</span>
							<span>Enemies</span>
						</span>
						<span class="charDispBod">
							<span ng-repeat="(ind, allyV) in allyVs" class="dispItem">
								<span>{{"{{allyV.name}}"}}</span>
								<span class="menu menuText  menuBordR">X</span>
							</span>
						</span>
						<span class="charDispBod">
							<span ng-repeat="(ind, enemV) in enemVs" class="dispItem">
								<span>{{"{{enemV.name}}"}}</span>
								<span class="menu menuText menuBordT menuBordR">X</span>
							</span>
						</span>
					</span>
					<span id="vehicleMenu">
						<span class="menu menuText menuBordT">+ AV</span>
						<span class="menu menuText menuBordT">+ EV</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Hull</span>
							</span>
							<span class="menu menuText">-</span>
							<span class="menu menuText">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>System</span>
							</span>
							<span class="menu menuText">-</span>
							<span class="menu menuText">+</span>
						</span>
					</span> -->
				</span>
			</div>
		</div>
	</div>
</body>
</html>
