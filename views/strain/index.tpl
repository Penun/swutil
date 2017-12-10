{{template "includes/strain/header.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
			<div id="menu" class="sixty_he" ng-show="mCont.ShowStep(0)">
				<ul>
					<li class="clickable" ng-click="SetStep(3, true)">Note</li>
					<li class="clickable" ng-click="SetStep(2, true)">Stats</li>
				</ul>
			</div>
			<div ng-show="mCont.ShowStep(10)" class="sixty_he">
				<p class="note">{{"{{activeNote}}"}}</p>
				<button ng-click="mCont.ReadNote()">Read</button>
			</div>
            <div ng-show="mCont.ShowStep(1)" class="sixty_he">
                <form id="charAddForm" name="charAddForm" novalidate>
                    <span class="full_width"><label><b>Name:</b></label><input type="text" name="charName" id="charName" ng-model="char.name" placeholder="Name" tabindex="1" autofocus required/></span>
                    <span class="full_width"><label><b>Wound Threshold:</b></label><input type="number" name="cahrWound" id="charWound" ng-model="char.wound" min="0" tabindex="2" required placeholder="0" /></span>
                    <span class="full_width"><label><b>Strain Threshold:</b></label><input type="number" name="charStrain" id="charStrain" ng-model="char.strain" min="0" tabindex="3" required placeholder="0" /></span>
                    <span class="full_width"><label><b>Brawn:</b></label><input type="number" name="charBrawn" id="charBrawn" ng-model="char.brawn" min="0" tabindex="4" required placeholder="0" /></span>
                    <span class="full_width"><label><b>Agility:</b></label><input type="number" name="charAgility" id="charAgility" ng-model="char.agility" min="0" tabindex="5" required placeholder="0" /></span>
                    <span class="full_width"><label><b>Intellect:</b></label><input type="number" name="charIntellect" id="charIntellect" ng-model="char.intellect" min="0" tabindex="6" required placeholder="0" /></span>
                    <span class="full_width"><label><b>Cunning:</b></label><input type="number" name="charCunning" id="charCunning" ng-model="char.cunning" min="0" tabindex="7" required placeholder="0" /></span>
                    <span class="full_width"><label><b>Willpower:</b></label><input type="number" name="charWillpower" id="charWillpower" ng-model="char.willpower" min="0" tabindex="8" required placeholder="0" /></span>
                    <span class="full_width"><label><b>Presence:</b></label><input type="number" name="charPresence" id="charPresence" ng-model="char.presence" min="0" tabindex="9" required placeholder="0" /></span>
                    <span class="full_width s_ws_p_inline"><label><b>Skills</b></label></span>
                    <span class="full_width"><label><b>Astrogation:</b></label><input type="number" name="charAstro" id="charAstro" ng-model="char.astrogation" min="0" tabindex="10" placeholder="0" /></span>
                    <span class="full_width"><label><b>Athletics:</b></label><input type="number" name="charAthletics" id="charAthletics" ng-model="char.athletics" min="0" tabindex="11" placeholder="0" /></span>
                    <span class="full_width"><label><b>Brawl:</b></label><input type="number" name="charBrawl" id="charBrawl" ng-model="char.brawl" min="0" tabindex="12" placeholder="0" /></span>
                    <span class="full_width"><label><b>Charm:</b></label><input type="number" name="charCharm" id="charCharm" ng-model="char.charm" min="0" tabindex="13" placeholder="0" /></span>
                    <span class="full_width"><label><b>Coercion:</b></label><input type="number" name="charCoercion" id="charCoercion" ng-model="char.coercion" min="0" tabindex="14" placeholder="0" /></span>
                    <span class="full_width"><label><b>Computers:</b></label><input type="number" name="charComputers" id="charComputers" ng-model="char.computers" min="0" tabindex="15" placeholder="0" /></span>
                    <span class="full_width"><label><b>Cool:</b></label><input type="number" name="charCool" id="charCool" ng-model="char.cool" min="0" tabindex="16" placeholder="0" /></span>
                    <span class="full_width"><label><b>Coordination:</b></label><input type="number" name="charCoordination" id="charCoordination" ng-model="char.coordination" min="0" tabindex="17" placeholder="0" /></span>
                    <span class="full_width"><label><b>Knowledge (Core Worlds):</b></label><input type="number" name="charCore" id="charCore" ng-model="char.core_worlds" min="0" tabindex="18" placeholder="0" /></span>
                    <span class="full_width"><label><b>Deception:</b></label><input type="number" name="charDeception" id="charDeception" ng-model="char.deception" min="0" tabindex="19" placeholder="0" /></span>
                    <span class="full_width"><label><b>Discipline:</b></label><input type="number" name="charDiscipline" id="charDiscipline" ng-model="char.discipline" min="0" tabindex="20" placeholder="0" /></span>
                    <span class="full_width"><label><b>Knowledge (Education):</b></label><input type="number" name="charEducation" id="charEducation" ng-model="char.education" min="0" tabindex="21" placeholder="0" /></span>
                    <span class="full_width"><label><b>Gunnery:</b></label><input type="number" name="charGunnery" id="charGunnery" ng-model="char.gunnery" min="0" tabindex="22" placeholder="0" /></span>
                    <span class="full_width"><label><b>Leadership:</b></label><input type="number" name="charLeader" id="charLeader" ng-model="char.leadership" min="0" tabindex="23" placeholder="0" /></span>
                    <span class="full_width"><label><b>Lightsaber:</b></label><input type="number" name="charLightsaber" id="charLightsaber" ng-model="char.lightsaber" min="0" tabindex="24" placeholder="0" /></span>
                    <span class="full_width"><label><b>Knowledge (Lore):</b></label><input type="number" name="charLore" id="charLore" ng-model="char.lore" min="0" tabindex="25" placeholder="0" /></span>
                    <span class="full_width"><label><b>Mechanics:</b></label><input type="number" name="charMechanics" id="charMechanics" ng-model="char.mechanics" min="0" tabindex="26" placeholder="0" /></span>
                    <span class="full_width"><label><b>Medicine:</b></label><input type="number" name="charMedicine" id="charMedicine" ng-model="char.medicine" min="0" tabindex="27" placeholder="0" /></span>
					<span class="full_width"><label><b>Melee:</b></label><input type="number" name="charMelee" id="charMelee" ng-model="char.melee" min="0" tabindex="28" placeholder="0" /></span>
                    <span class="full_width"><label><b>Negotiation:</b></label><input type="number" name="charNego" id="charNego" ng-model="char.negotiation" min="0" tabindex="29" placeholder="0" /></span>
                    <span class="full_width"><label><b>Knowledge (Outer Rim):</b></label><input type="number" name="charOuter" id="charOuter" ng-model="char.outer_rim" min="0" tabindex="30" placeholder="0" /></span>
                    <span class="full_width"><label><b>Perception:</b></label><input type="number" name="charPerception" id="charPerception" ng-model="char.perception" min="0" tabindex="31" placeholder="0" /></span>
                    <span class="full_width"><label><b>Piloting (Planetary):</b></label><input type="number" name="charPilotP" id="charPilotP" ng-model="char.piloting_p" min="0" tabindex="32" placeholder="0" /></span>
                    <span class="full_width"><label><b>Piloting (Space):</b></label><input type="number" name="charPilotS" id="charPilotS" ng-model="char.piloting_s" min="0" tabindex="33" placeholder="0" /></span>
                    <span class="full_width"><label><b>Ranged (Heavy):</b></label><input type="number" name="charRangedH" id="charRangedH" ng-model="char.ranged_h" min="0" tabindex="34" placeholder="0" /></span>
                    <span class="full_width"><label><b>Ranged (Light):</b></label><input type="number" name="charRangedL" id="charRangedL" ng-model="char.ranged_l" min="0" tabindex="35" placeholder="0" /></span>
                    <span class="full_width"><label><b>Resilience:</b></label><input type="number" name="charResil" id="charResil" ng-model="char.resilience" min="0" tabindex="36" placeholder="0" /></span>
                    <span class="full_width"><label><b>Skulduggery:</b></label><input type="number" name="charSkul" id="charSkul" ng-model="char.skulduggery" min="0" tabindex="37" placeholder="0" /></span>
                    <span class="full_width"><label><b>Stealth:</b></label><input type="number" name="charStealth" id="charStealth" ng-model="char.stealth" min="0" tabindex="38" placeholder="0" /></span>
                    <span class="full_width"><label><b>Streetwise:</b></label><input type="number" name="charStreet" id="charStreet" ng-model="char.streetwise" min="0" tabindex="39" placeholder="0" /></span>
                    <span class="full_width"><label><b>Survival:</b></label><input type="number" name="charSurvival" id="charSurvival" ng-model="char.survival" min="0" tabindex="40" placeholder="0" /></span>
                    <span class="full_width"><label><b>Knowledge (Underworld):</b></label><input type="number" name="charUnder" id="charUnder" ng-model="char.underworld" min="0" tabindex="41" placeholder="0" /></span>
					<span class="full_width"><label><b>Vigilance:</b></label><input type="number" name="charVigil" id="charVigil" ng-model="char.vigilance" min="0" tabindex="42" placeholder="0" /></span>
                    <span class="full_width"><label><b>Knowledge (Warfare):</b></label><input type="number" name="charWarfare" id="charWarfare" ng-model="char.warfare" min="0" tabindex="43" placeholder="0" /></span>
                    <span class="full_width"><label><b>Knowledge (Xenology):</b></label><input type="number" name="charXenology" id="charXenology" ng-model="char.xenology" min="0" tabindex="44" placeholder="0" /></span>
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
					<p class="s_ws_p_inline"><label for="subSel"><b>Players:</b></label></p>
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
