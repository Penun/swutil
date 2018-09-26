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
							<span>Players</span>
						</span>
						<span class="sw_back">
							<span class="charAltHead">
								<span>Allies</span>
								<span class="menu menuText" ng-click="mCont.SetupAdd('NPC')">+</span>
							</span>
						</span>
						<span class="sw_back">
							<span class="charAltHead">
								<span>Enemies</span>
								<span class="menu menuText" ng-click="mCont.SetupAdd('NPCE')">+</span>
							</span>
						</span>
						<span class="charDispBod">
							<span ng-repeat="(ind, play) in players" class="dispItem">
								<span>{{"{{play.player.name}}"}}</span>
								<span class="menu menuText menuBordT menuBordR">X</span>
							</span>
						</span>
						<span class="charDispBod">
							<span ng-show="mCont.addAction != 'NPC'" class="charDispBodInn">
								<span ng-repeat="(ind, ally) in allies" class="dispItem">
									<span>{{"{{ally.player.name}}"}}</span>
									<span class="menu menuText menuBordT menuBordR">X</span>
								</span>
							</span>
							<span ng-show="mCont.addAction == 'NPC'" class="">
								<span class="menu menuText" ng-click="mCont.ClearForm(5, false)">Cancel</span>
								<form name="addAllyForm" id="addAllyForm" novalidate>
									<span>
										<span>Name:</span><span><input type="text" name="addNameA" id="addNameA" ng-model="mCont.addForm.name" placeholder="Name" required/></span>
										<span>Wound:</span><span><input type="number" name="addWoundA" id="addWoundA" ng-model="mCont.addForm.wound" placeholder="0" required/></span>
										<span>Strain:</span><span><input type="number" name="addStrainA" id="addStrainA" ng-model="mCont.addForm.strain" placeholder="0" /></span>
										<span>Initiative:</span><span><input type="number" name="addInitA" id="addInitA" ng-model="mCont.addForm.initiative" step="any" placeholder="0" required/></span>
										<span></span><span ng-show="addAllyForm.$valid" ng-click="mCont.AddForm()">Add</span>
									</span>
								</form>
							</span>
						</span>
						<span class="charDispBod">
							<span ng-show="mCont.addAction != 'NPCE'" class="charDispBodInn">
								<span ng-repeat="(ind, enem) in enems" class="dispItem">
									<span>{{"{{enem.player.name}}"}}</span>
									<span class="menu menuText menuBordT menuBordR">X</span>
								</span>
							</span>
							<span ng-show="mCont.addAction == 'NPCE'" class="">
								<span class="menu menuText" ng-click="mCont.ClearForm(5, false)">Cancel</span>
								<form name="addEnemForm" id="addEnemForm" novalidate>
									<span>
										<span>Name:</span><span><input type="text" name="addNameE" id="addNameE" ng-model="mCont.addForm.name" placeholder="Name" required/></span>
										<span>Wound:</span><span><input type="number" name="addWoundE" id="addWoundE" ng-model="mCont.addForm.wound" placeholder="0" required/></span>
										<span>Strain:</span><span><input type="number" name="addStrainE" id="addStrainE" ng-model="mCont.addForm.strain" placeholder="0" /></span>
										<span>Initiative:</span><span><input type="number" name="addInitE" id="addInitE" ng-model="mCont.addForm.initiative" step="any" placeholder="0" required/></span>
										<span></span><span ng-show="addEnemForm.$valid" ng-click="mCont.AddForm(false)">Add</span>
									</span>
								</form>
							</span>
						</span>
					</span>
					<span id="characterMenu">
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Wound</span>
							</span>
							<span class="menu menuText">-</span>
							<span class="menu menuText">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Strain</span>
							</span>
							<span class="menu menuText">-</span>
							<span class="menu menuText">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Boost</span>
							</span>
							<span class="menu menuText">-</span>
							<span class="menu menuText">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Setback</span>
							</span>
							<span class="menu menuText">-</span>
							<span class="menu menuText">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Upgrade</span>
							</span>
							<span class="menu menuText">-</span>
							<span class="menu menuText">+</span>
						</span>
						<span class="menuColSpan menuTitledBlock">
							<span class="sw_back menuColSpan">
								<span>Up Diff</span>
							</span>
							<span class="menu menuText">-</span>
							<span class="menu menuText">+</span>
						</span>
					</span>
					<span id="initiativeDisp" class="charDispBod">
						<span ng-show="!startInit && (players.length > 0 || allies.length > 0 || enems.length > 0)">There</span>
						<span ng-show="startInit">Initiative running....</span>
					</span>
					<span id="initiativeMenu" class="menuTitledBlock">
						<span class="menu menuBordT menuText menuColSpan" ng-show="players.length > 0 || allies.length > 0 || enems.length > 0" ng-click="mCont.ToggleInit()">{{"{{startInit ? \"End\" : \"Start\"}}"}}</span>
						<span class="menu menuText" ng-show="startInit" ng-click="mCont.PrevTurn()"><</span>
						<span class="menu menuText" ng-show="startInit" ng-click="mCont.NextTurn()">></span>
					</span>
					<span id="vehicleDisp">
						<span class="menuColSpan sw_back">
							<span class="menuColSpan">Vehicles</span>
							<span>Allies</span>
							<span>Enemies</span>
						</span>
						<span class="charDispBod">
							<span ng-repeat="(ind, allyV) in allyVs" class="dispItem">
								<span>{{"{{allyV.name}}"}}</span>
								<span class="menu menuText menuBordT menuBordR">X</span>
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
					</span>
				</span>
			</div>
			<!-- <div ng-show="mCont.ShowStep(3)" class="sixty_he">
				<button class="menu_p" ng-click="mCont.ClearForm(3, true)">Menu</button>
				<form name="actForm" id="actForm" novalidate>
					<p class="s_ws_p_inline"><label for="subSelAct"><b>Players:</b></label></p>
					<select name="subSelAct" id="subSelAct" ng-model="mCont.action.players" ng-options="sub.player.name as sub.player.name for sub in subs" multiple required></select>
					<button ng-show="actForm.$valid && !startInit" ng-click="mCont.Initiative()">Initiative</button>
					<button ng-show="actForm.$valid && !startInit" ng-click="mCont.DelPlayer()">Delete</button>
				</form>
				<p class="act_p">
					<button ng-click="mCont.SetupAdd('NPCE')">Add Enemy</button>
					<button ng-click="mCont.SetupDel('NPCE')">Delete Enemy</button>
				</p>
				<p class="act_p">
					<button ng-click="mCont.SetupAdd('NPC')">Add Friendly</button>
					<button ng-click="mCont.SetupDel('NPC')">Delete Friendly</button>
				</p>
				<p class="s_ws_p_inline" ng-show="startInit">Initiative Tracker Running...</p>
				<p class="act_p" ng-show="!startInit"><button ng-click="mCont.StartInit()">Start Initiative</button></p>
				<p class="act_p" ng-show="startInit">
					<button ng-click="mCont.NextTurn()">Next Turn</button>
					<button ng-click="mCont.PrevTurn()">Prev Turn</button>
					<button ng-click="mCont.EndInit()">End Initiative</button>
				</p>
				<p class="s_ws_p_inline" ng-show="enems.length > 0"><label><b>Enemies:</b></label>
					<ul>
						<li ng-repeat="(ind, enem) in enems">{{"{{enem.player.name}}"}} `~` Wo:{{"{{enem.cur_wound}}"}}/{{"{{enem.player.wound}}"}}<div ng-show="enem.player.strain != null">, St:{{"{{enem.cur_strain}}"}}/{{"{{enem.player.strain}}"}}</div></li>
					</ul>
				</p>
				<p class="act_p" ng-show="startInit && enems.length > 0"><button ng-click="mCont.SetupDam('NPCE')">Adjust Enemy</button></p>
				<p class="act_p" ng-show="startInit && friends.length > 0"><button ng-click="mCont.SetupDam('NPC')">Adjust Friend</button></p>
			</div> -->
			<div ng-show="mCont.ShowStep(5)" class="sixty_he">
				<button class="menu_p" ng-click="mCont.ClearForm(5, true)">Cancel</button>
				<form name="addForm" id="addForm" novalidate>
					<p class="s_ws_p_inline"><label for="addName"><b>Name:</b></label> <input type="text" name="addName" id="addName" ng-model="mCont.addForm.name" placeholder="Name" required/></p>
					<p class="s_ws_p_inline"><label for="addInit"><b>Initiative:</b></label> <input type="number" name="addInit" id="addInit" ng-model="mCont.addForm.initiative" placeholder="0" required/></p>
					<p class="s_ws_p_inline"><label for="addWound"><b>Wound:</b></label> <input type="number" name="addWound" id="addWound" ng-model="mCont.addForm.wound" placeholder="0" required/></p>
					<p class="s_ws_p_inline"><label for="addStrain"><b>Strain:</b></label> <input type="number" name="addStrain" id="addStrain" ng-model="mCont.addForm.strain" placeholder="0" /></p>
					<button ng-show="addForm.$valid" ng-click="mCont.AddForm(false)">Add</button>
				</form>
			</div>
			<div ng-show="mCont.ShowStep(6)" class="sixty_he">
				<p><button class="menu_p" ng-click="mCont.ClearForm(6, true)">Cancel</button></p>
				<form name="delForm" id="delForm" novalidate>
					<p class="s_ws_p_inline"><label for="enemSel"><b>{{"{{mCont.delAction}}"}}:</b></label></p>
					<select name="enemSel" id="enemSel" ng-show="mCont.delChars.length > 0" ng-model="mCont.delForm.chars" ng-options="char.player.name as char.player.name for char in mCont.delChars" multiple required></select>
					<button ng-show="delForm.$valid" ng-click="mCont.DelForm(false)">Delete</button>
				</form>
			</div>
			<div ng-show="mCont.ShowStep(7)" class="sixty_he">
				<p><button class="menu_p" ng-click="mCont.ClearForm(7, true)">Cancel</button></p>
				<form name="damForm" id="damForm" novalidate>
					<p class="s_ws_p_inline"><label for="damCharSel"><b>Enemies:</b></label></p>
					<select name="damCharSel" id="damCharSel" ng-show="mCont.damChars.length > 0" ng-model="mCont.damForm.chars" ng-options="char.player.name as char.player.name for char in mCont.damChars" multiple required></select>
					<p class="s_ws_p_inline"><label for="damCharType"><b>Wound:</b></label> <input type="radio" name="damCharType" ng-model="mCont.damForm.type" value="wound" required/>
					<label for="damCharType"><b>Strain:</b></label> <input type="radio" name="damCharType" ng-model="mCont.damForm.type" value="strain" required/></p>
					<p class="s_ws_p_inline"><label for="damCharIn"><b>Amount:</b></label> <input type="number" name="damCharIn" id="damCharIn" ng-model="mCont.damForm.damage" placeholder="0" required/></p>
					<p class="act_p"><button ng-show="damForm.$valid" ng-click="mCont.DamForm(false, true)">Damage</button>
					<button ng-show="damForm.$valid" ng-click="mCont.DamForm(false, false)">Heal</button></p>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
