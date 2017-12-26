{{template "includes/game/header_d.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
			<div ng-show="mCont.ShowStep(10)" class="sixty_he">
				<p class="note">{{"{{activeNote}}"}}</p>
				<button ng-click="mCont.ReadNote()">Read</button>
			</div>
            <div ng-show="mCont.ShowStep(1)" class="sixty_he">
				<ul>
					<li class="clickable" ng-click="mCont.InTextSet('Note')">Note</li>
					<li class="clickable" ng-click="mCont.ActionSet('Initiative')">Initiative</li>
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
				<button class="menu_p" ng-click="mCont.ClearForm(3, true)">Menu</button>
				<form name="actForm" id="actForm" ng-show="!startInit" novalidate>
					<p class="s_ws_p_inline"><label for="subSelAct"><b>Players:</b></label></p>
					<select name="subSelAct" id="subSelAct" ng-model="mCont.action.players" ng-options="sub.player.name as sub.player.name for sub in subs" multiple required></select>
					<button ng-show="actForm.$valid" ng-click="mCont.Action()">{{"{{mCont.actionText}}"}}</button>
				</form>
				<p class="act_p" ng-show="mCont.actionText == 'Initiative' && !startInit">
					<button ng-click="mCont.AddEnemy(true)">Add Enemy</button>
					<button ng-click="mCont.DelEnemy(true)">Delete Enemy</button>
				</p>
				<p class="s_ws_p_inline" ng-show="startInit">Initiative Tracker Running...</p>
				<p class="act_p" ng-show="mCont.actionText == 'Initiative' && !startInit"><button ng-click="mCont.StartInit()">Start Initiative</button></p>
				<p class="act_p" ng-show="mCont.actionText == 'Initiative' && startInit">
					<button ng-click="mCont.NextTurn()">Next Turn</button>
					<button ng-click="mCont.PrevTurn()">Prev Turn</button>
					<button ng-click="mCont.EndInit()">End Initiative</button>
				</p>
				<p class="s_ws_p_inline" ng-show="enems.length > 0"><label><b>Enemies:</b></label>
					<ul>
						<li ng-repeat="(ind, enem) in enems">{{"{{enem.player.name}}"}} `~` Wo:{{"{{enem.curWound}}"}}/{{"{{enem.player.wound}}"}} `~` St:{{"{{enem.curStrain}}"}}/{{"{{enem.player.strain}}"}}</li>
					</ul>
				</p>
				<p class="act_p" ng-show="mCont.actionText == 'Initiative' && startInit && enems.length > 0"><button ng-click="mCont.DamageEnemy(true, false)">Adjust Enemy</button></p>
			</div>
			<div ng-show="mCont.ShowStep(5)" class="sixty_he">
				<button class="menu_p" ng-click="mCont.ClearForm(5, true)">Cancel</button>
				<form name="addForm" id="addForm" novalidate>
					<p class="s_ws_p_inline"><label for="addName"><b>Name:</b></label> <input type="text" name="addName" id="addName" ng-model="mCont.addForm.name" placeholder="Name" required/></p>
					<p class="s_ws_p_inline"><label for="addInit"><b>Initiative:</b></label> <input type="number" name="addInit" id="addInit" ng-model="mCont.addForm.initiative" placeholder="0" required/></p>
					<p class="s_ws_p_inline"><label for="addWound"><b>Wound:</b></label> <input type="number" name="addWound" id="addWound" ng-model="mCont.addForm.wound" placeholder="0" required/></p>
					<p class="s_ws_p_inline"><label for="addStrain"><b>Strain:</b></label> <input type="number" name="addStrain" id="addStrain" ng-model="mCont.addForm.strain" placeholder="0" /></p>
					<button ng-show="addForm.$valid" ng-click="mCont.AddEnemy(false)">Add</button>
				</form>
			</div>
			<div ng-show="mCont.ShowStep(6)" class="sixty_he">
				<p><button class="menu_p" ng-click="mCont.ClearForm(6, true)">Cancel</button></p>
				<form name="delEnForm" id="delEnForm" novalidate>
					<p class="s_ws_p_inline"><label for="enemSel"><b>Enemies:</b></label></p>
					<select name="enemSel" id="enemSel" ng-show="enems.length > 0" ng-model="mCont.delEnem.enems" ng-options="enem.player.name as enem.player.name for enem in enems" multiple required></select>
					<button ng-show="delEnForm.$valid" ng-click="mCont.DelEnemy(false)">Delete</button>
				</form>
			</div>
			<div ng-show="mCont.ShowStep(7)" class="sixty_he">
				<p><button class="menu_p" ng-click="mCont.ClearForm(7, true)">Cancel</button></p>
				<form name="damEnForm" id="damEnForm" novalidate>
					<p class="s_ws_p_inline"><label for="enemDamSel"><b>Enemies:</b></label></p>
					<select name="enemDamSel" id="enemDamSel" ng-show="enems.length > 0" ng-model="mCont.damEnem.enems" ng-options="enem.player.name as enem.player.name for enem in enems" multiple required></select>
					<p class="s_ws_p_inline"><label for="damEnemIn"><b>Wound:</b></label> <input type="radio" name="damEnemType" ng-model="mCont.damEnem.type" value="wound" required/>
					<label for="damEnemIn"><b>Strain:</b></label> <input type="radio" name="damEnemType" ng-model="mCont.damEnem.type" value="strain" required/></p>
					<p class="s_ws_p_inline"><label for="damEnemIn"><b>Amount:</b></label> <input type="number" name="damEnemIn" id="damEnemIn" ng-model="mCont.damEnem.damage" placeholder="0" required/></p>
					<p class="act_p"><button ng-show="damEnForm.$valid" ng-click="mCont.DamageEnemy(false, true)">Damage</button>
					<button ng-show="damEnForm.$valid" ng-click="mCont.DamageEnemy(false, false)">Heal</button></p>
				</form>
			</div>
			<div ng-show="mCont.ShowStep(4)" class="sixty_he">
				<p><button class="menu_p" ng-click="mCont.ClearForm(4, true)">Menu</button></p>
				<form name="inpForm" id="inpForm" novalidate>
					<p class="s_ws_p_inline"><label for="subSelInp"><b>Players:</b></label></p>
					<select name="subSelInp" id="subSelInp" ng-show="subs.length > 0" ng-model="mCont.inpForm.players" ng-options="sub.player.name as sub.player.name for sub in subs" multiple required></select>
					<p class="s_ws_p_inline"><label for="inpIn"><b>{{"{{mCont.inputText}}"}}:</b></label> <input type="number" name="inpIn" id="inpIn" ng-model="mCont.inpForm.input" placeholder="0" required/></p>
					<button ng-show="inpForm.$valid" ng-click="mCont.Input()">{{"{{mCont.inputText}}"}}</button>
				</form>
            </div>
		</div>
	</div>
</body>
</html>
