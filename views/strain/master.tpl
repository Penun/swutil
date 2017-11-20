{{template "includes/strain/header_d.tpl"}}
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
				<p class="s_ws_p_inline"><button ng-click="mCont.ClearForm(2, true)">Menu</button></p>
				<form name="inTextForm" id="inTextForm" novalidate>
					<select name="subSelInText" id="subSelInText" ng-show="subs.length > 0" ng-model="mCont.inText.players" ng-options="sub.name as sub.name for sub in subs" multiple required></select>
					<p class="s_ws_p_inline"><label for="inTextMessage"><b>{{"{{mCont.inTextText}}"}}:</b></label></p>
					<textarea name="inTextMessage" id="inTextMessage" ng-model="mCont.inText.message" ng-required="mCont.textareaReq"></textarea>
					<button ng-show="inTextForm.$valid" ng-click="mCont.InText()">Send</button>
				</form>
			</div>
			<div ng-show="mCont.ShowStep(3)" class="sixty_he">
				<p class="s_ws_p_inline"><button ng-click="mCont.ClearForm(3, true)">Menu</button></p>
				<form name="actForm" id="actForm" ng-show="!mCont.startInit" novalidate>
					<select name="subSelAct" id="subSelAct" ng-model="mCont.action.players" ng-options="sub.name as sub.name for sub in subs" multiple required></select>
					<button ng-show="actForm.$valid" ng-click="mCont.Action()">{{"{{mCont.actionText}}"}}</button>
				</form>
				<p class="s_ws_p_inline" ng-show="mCont.startInit">Initiative Tracker Running...</p>
				<button ng-show="mCont.actionText == 'Initiative'" ng-click="mCont.StartInit()">{{"{{mCont.startInit ? \"End\" : \"Start\"}}"}} Initiative</button>
				<button ng-show="mCont.actionText == 'Initiative' && mCont.startInit" ng-click="mCont.PrevTurn()">Prev Turn</button>
				<button ng-show="mCont.actionText == 'Initiative' && mCont.startInit" ng-click="mCont.NextTurn()">Next Turn</button>
			</div>
			<div ng-show="mCont.ShowStep(4)" class="sixty_he">
				<p class="s_ws_p_inline"><button ng-click="mCont.ClearForm(4, true)">Menu</button></p>
				<form name="inpForm" id="inpForm" novalidate>
					<select name="subSelInp" id="subSelInp" ng-show="subs.length > 0" ng-model="mCont.inpForm.players" ng-options="sub.name as sub.name for sub in subs" multiple required></select>
					<p class="s_ws_p_inline"><label for="inpIn"><b>{{"{{mCont.inputText}}"}}:</b></label> <input type="number" name="inpIn" id="inpIn" ng-model="mCont.inpForm.input" placeholder="0" required/></p>
					<button ng-show="inpForm.$valid" ng-click="mCont.Input()">{{"{{mCont.inputText}}"}}</button>
				</form>
            </div>
		</div>
	</div>
</body>
</html>
