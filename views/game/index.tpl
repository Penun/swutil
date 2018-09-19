{{template "includes/game/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
			<div id="menu" class="sixty_he" ng-show="mCont.ShowStep(0)">
				<ul>
					<li class="clickable" ng-click="SetStep(3, true)">Note</li>
					<li class="clickable" ng-click="SetStep(2, true)">Game</li>
				</ul>
			</div>
			<div ng-show="mCont.ShowStep(10)" class="sixty_he">
				<span class="playerGrid">
					<span class="playerGridInner">
						<span class="noteRowSpan charDispBod">{{"{{activeNote}}"}}</span>
						<span class="menu menuText" ng-click="mCont.ReadNote()">Read</span>
					</span>
				</span>
			</div>
            <div ng-show="mCont.ShowStep(1)" class="sixty_he">
                <form id="charAddForm" name="charAddForm" novalidate>
                    <span class="full_width"><label><b>Name:</b></label><input type="text" name="charName" id="charName" ng-model="char.name" ng-change="mCont.FindPlayer()" placeholder="Name" tabindex="1" list="playSugs" autofocus required/>
						<datalist id="playSugs">
							<option ng-repeat="(ind, pSug) in playSugs" value="{{"{{pSug.name}}"}}">
						</datalist>
					</span>
                    <button ng-show="charAddForm.$valid" ng-click="mCont.AddChar()" class="menu_p">Add</button>
                </form>
            </div>
			<div ng-show="mCont.ShowStep(2)" class="sixty_he">
				<span class="playerGrid">
					<span class="playerGridInner">
						<span class="sw_back">
							<span>{{"{{curChar.name}}"}}</span>
						</span>
						<span class="menu mainMenuButton">
							<span class="menuInner" ng-click="SetStep(0, false)"></span>
						</span>
						<span class="dualBlock">
							<span class="sw_back">
								<span>Wound:</span>
							</span>
							<span class="charDispBod">
								<span class="dispItem">{{"{{curChar.curWound}}"}} / {{"{{curChar.wound}}"}}</span>
							</span>
						</span>
						<span class="dualBlock">
							<span class="menu menuText menuBordT" ng-click="mCont.Wound(-1)">-</span>
							<span class="menu menuText menuBordT" ng-click="mCont.Wound(1)">+</span>
						</span>
						<span class="dualBlock">
							<span class="sw_back">
								<span>Strain:</span>
							</span>
							<span class="charDispBod">
								<span class="dispItem">{{"{{curChar.curStrain}}"}} / {{"{{curChar.strain}}"}}</span>
							</span>
						</span>
						<span class="dualBlock">
							<span class="menu menuText menuBordT" ng-click="mCont.Strain(-1)">-</span>
							<span class="menu menuText menuBordT" ng-click="mCont.Strain(1)">+</span>
						</span>
						<span class="dualBlock">
							<span class="sw_back">
								<span>Initiative:</span>
							</span>
							<span class="charDispBod" ng-show="curChar.initiative > 0">
								<span class="dispItem">{{"{{curChar.initiative}}"}}</span>
							</span>
							<form name="iniForm" id="iniForm" ng-show="curChar.initiative <= 0" novalidate>
								<span id="innerIniForm">
									<span class="inputBod">
										<input type="number" name="inpIn" id="inpIn" ng-model="mCont.inpForm.input" class="inputInit" placeholder="0" required/>
									</span>
								</span>
							</form>
						</span>
						<span class="menu menuText menuBordT menuBordR" ng-show="inpForm.$valid" ng-click="mCont.Input('Initiative')">Set</span>
						<span class="menu menuText menuBordT menuBordR" ng-show="curChar.initiative > 0" ng-click="mCont.ResetInit()">Reset</span>
					</span>
				</span>
			</div>
			<div ng-show="mCont.ShowStep(3)" class="sixty_he">
				<p class="menu_p"><button ng-click="SetStep(0, false)">Menu</button></p>
				<form name="noteForm" id="noteForm" novalidate>
					<p class="s_ws_p_inline"><label for="subSel"><b>Players:</b></label></p>
					<select name="subSel" id="subSel" ng-show="subs.length > 0" ng-model="note.players" ng-options="sub.player.name as sub.player.name for sub in subs" multiple required></select>
					<p class="s_ws_p_inline"><label for="noteMessage"><b>Note:</b></label></p>
					<textarea name="noteMessage" id="noteMessage" ng-model="note.message" ng-required="textareaReq"></textarea>
					<button ng-show="noteForm.$valid" ng-click="mCont.SendNote()">Send</button>
				</form>
			</div>
			<div ng-show="mCont.ShowStep(4)" class="sixty_he">
				<p class="menu_p"><button ng-click="mCont.ClearForm()">Cancel</button></p>
				<form name="inpForm" id="inpForm" novalidate>
					<p class="s_ws_p_inline"><label for="damIn"><b>{{"{{mCont.formInput}}"}}:</b></label> <input type="number" name="inpIn" id="inpIn" ng-model="mCont.inpForm.input" placeholder="0" required/></p>
					<button ng-show="inpForm.$valid" ng-click="mCont.Input()">{{"{{mCont.formInput}}"}}</button>
				</form>
            </div>
		</div>
	</div>
</body>
</html>
