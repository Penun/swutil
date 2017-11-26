{{template "includes/strain/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
			<div id="menu" class="sixty_he" ng-show="mCont.ShowStep(0)">
				<ul>
					<li class="clickable" ng-click="SetStep(3, true)">Note</li>
					<li class="clickable" ng-click="SetStep(2, true)">Stats</li>
					<li class="clickable" ng-click="SetStep(backStep, false)">Cancel</li>
				</ul>
			</div>
			<div ng-show="mCont.ShowStep(10)" class="sixty_he">
				<p class="note">{{"{{activeNote}}"}}</p>
				<button ng-click="mCont.ReadNote()">Read</button>
			</div>
            <div ng-show="mCont.ShowStep(1)" class="sixty_he">
                <form id="charAddForm" name="charAddForm" novalidate>
                    <p><label><b>Name:</b></label><input type="text" name="charName" id="charName" ng-model="char.name" tabindex="1" autofocus required/></p>
                    <p><label><b>Wound Threshold:</b></label><input type="number" name="cahrWound" id="charWound" ng-model="char.wound" min="0" tabindex="2" required/></p>
                    <p><label><b>Strain Threshold:</b></label><input type="number" name="charStrain" id="charStrain" ng-model="char.strain" min="0" tabindex="3" required/></p>
                    <button ng-show="charAddForm.$valid" ng-click="mCont.AddChar()" class="menu_p">Add</button>
                </form>
            </div>
            <div ng-show="mCont.ShowStep(2)" class="sixty_he">
				<p class="menu_p"><button ng-click="SetStep(0, false)">Menu</button></p>
                <p class="s_ws_p_inline"><label><b>{{"{{char.name}}"}}</b></label></p>
                <p class="s_ws_p_inline"><label><b>W:</b></label> {{"{{curChar.wound}}"}}</p>
				<p class="s_ws_p_inline"><button ng-click="mCont.Wound(1)" class="inline_butt">+</button> <button ng-click="mCont.Wound(-1)" class="inline_butt">-</button></p>
                <p class="s_ws_p_inline"><label><b>S:</b></label> {{"{{curChar.strain}}"}}</p>
				<p class="s_ws_p_inline"><button ng-click="mCont.Strain(1)" class="inline_butt">+</button> <button ng-click="mCont.Strain(-1)" class="inline_butt">-</button></p>
				<p class="s_ws_p_inline"><label><b>Initiative:</b></label> <span ng-show="curChar.initiative > 0" class="inline_span">{{"{{curChar.initiative}}"}}</span><button ng-show="curChar.initiative == 0" ng-click="mCont.InputSet('Initiative')" class="inline_butt">Set</button></p>
                <p class="s_ws_p_inline"><button ng-click="mCont.EndTurn()" ng-show="isTurn">End Turn</button></p>
            </div>
			<div ng-show="mCont.ShowStep(3)" class="sixty_he">
				<p class="menu_p"><button ng-click="SetStep(0, false)">Menu</button></p>
				<form name="noteForm" id="noteForm" novalidate>
					<select name="subSel" id="subSel" ng-show="subs.length > 0" ng-model="note.players" ng-options="sub.name as sub.name for sub in subs" multiple required></select>
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
