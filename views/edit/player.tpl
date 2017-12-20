<div ng-show="mCont.ShowTab(11)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Players</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, play) in players">
					    <span class="clickable">
                            {{"{{play.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page right_page_form">
        <form id="playAddForm" name="playAddForm" novalidate>
            <p><label for="playName"><b>Name:</b></label><input type="text" name="playName" id="playName" ng-model="moldPlay.name" ng-change="mCont.CheckPlay()" placeholder="Name" tabindex="1" autofocus required/></p>
            <p><label for="playWound"><b>Wound Threshold:</b></label><input type="number" name="playWound" id="playWound" ng-model="moldPlay.wound" min="0" tabindex="2" required placeholder="0"/></p>
            <p><label for="playStrain"><b>Strain Threshold:</b></label><input type="number" name="playStrain" id="playStrain" ng-model="moldPlay.strain" min="0" tabindex="3" required placeholder="0"/></p>
            <p><h2>Characteristics</h2></p>
            <p><label for="playBrawn"><b>Brawn:</b></label><input type="number" name="playBrawn" id="playBrawn" ng-model="moldPlay.brawn" min="1" max="6" tabindex="4" required placeholder="0"/></p>
            <p><label for="playAgility"><b>Agility:</b></label><input type="number" name="playAgility" id="playAgility" ng-model="moldPlay.agility" min="1" max="6" tabindex="5" required placeholder="0"/></p>
            <p><label for="playIntellect"><b>Intellect:</b></label><input type="number" name="playIntellect" id="playIntellect" ng-model="moldPlay.intellect" min="1" max="6" tabindex="6" required placeholder="0"/></p>
            <p><label for="playCunning"><b>Cunning:</b></label><input type="number" name="playCunning" id="playCunning" ng-model="moldPlay.cunning" min="1" max="6" tabindex="7" required placeholder="0"/></p>
            <p><label for="playWillpower"><b>Willpower:</b></label><input type="number" name="playWillpower" id="playWillpower" ng-model="moldPlay.willpower" min="1" max="6" tabindex="8" required placeholder="0"/></p>
            <p><label for="playPresence"><b>Presence:</b></label><input type="number" name="playPresence" id="playPresence" ng-model="moldPlay.presence" min="1" max="6" tabindex="9" required placeholder="0"/></p>
            <p><h2>Skills</h2></p>
            <p><label for="playAstro"><b>Astrogation:</b></label><input type="number" name="playAstro" id="playAstro" ng-model="moldPlay.astrogation" min="0" max="6" tabindex="10" placeholder="0" required/></p>
            <p><label for="playAthletics"><b>Athletics:</b></label><input type="number" name="playAthletics" id="playAthletics" ng-model="moldPlay.athletics" min="0" max="6" tabindex="11" placeholder="0" required/></p>
            <p><label for="playBrawl"><b>Brawl:</b></label><input type="number" name="playBrawl" id="playBrawl" ng-model="moldPlay.brawl" min="0" max="6" tabindex="12" placeholder="0" required/></p>
            <p><label for="playCharm"><b>Charm:</b></label><input type="number" name="playCharm" id="playCharm" ng-model="moldPlay.charm" min="0" max="6" tabindex="13" placeholder="0" required/></p>
            <p><label for="playCoercion"><b>Coercion:</b></label><input type="number" name="playCoercion" id="playCoercion" ng-model="moldPlay.coercion" min="0" max="6" tabindex="14" placeholder="0" required/></p>
            <p><label for="playComputers"><b>Computers:</b></label><input type="number" name="playComputers" id="playComputers" ng-model="moldPlay.computers" min="0" max="6" tabindex="15" placeholder="0" required/></p>
            <p><label for="playCool"><b>Cool:</b></label><input type="number" name="playCool" id="playCool" ng-model="moldPlay.cool" min="0" max="6" tabindex="16" placeholder="0" required/></p>
            <p><label for="playCoordination"><b>Coordination:</b></label><input type="number" name="playCoordination" id="playCoordination" ng-model="moldPlay.coordination" min="0" max="6" tabindex="17" placeholder="0" required/></p>
            <p><label for="playCore"><b>Knowledge (Core Worlds):</b></label><input type="number" name="playCore" id="playCore" ng-model="moldPlay.core_worlds" min="0" max="6" tabindex="18" placeholder="0" required/></p>
            <p><label for="playDeception"><b>Deception:</b></label><input type="number" name="playDeception" id="playDeception" ng-model="moldPlay.deception" min="0" max="6" tabindex="19" placeholder="0" required/></p>
            <p><label for="playDiscipline"><b>Discipline:</b></label><input type="number" name="playDiscipline" id="playDiscipline" ng-model="moldPlay.discipline" min="0" max="6" tabindex="20" placeholder="0" required/></p>
            <p><label for="playEducation"><b>Knowledge (Education):</b></label><input type="number" name="playEducation" id="playEducation" ng-model="moldPlay.education" min="0" max="6" tabindex="21" placeholder="0" required/></p>
            <p><label for="playGunnery"><b>Gunnery:</b></label><input type="number" name="playGunnery" id="playGunnery" ng-model="moldPlay.gunnery" min="0" max="6" tabindex="22" placeholder="0" required/></p>
            <p><label for="playLeader"><b>Leadership:</b></label><input type="number" name="playLeader" id="playLeader" ng-model="moldPlay.leadership" min="0" max="6" tabindex="23" placeholder="0" required/></p>
            <p><label for="playLightsaber"><b>Lightsaber:</b></label><input type="number" name="playLightsaber" id="playLightsaber" ng-model="moldPlay.lightsaber" min="0" max="6" tabindex="24" placeholder="0" required/></p>
            <p><label for="playLore"><b>Knowledge (Lore):</b></label><input type="number" name="playLore" id="playLore" ng-model="moldPlay.lore" min="0" max="6" tabindex="25" placeholder="0" required/></p>
            <p><label for="playMechanics"><b>Mechanics:</b></label><input type="number" name="playMechanics" id="playMechanics" ng-model="moldPlay.mechanics" min="0" max="6" tabindex="26" placeholder="0" required/></p>
            <p><label for="playMedicine"><b>Medicine:</b></label><input type="number" name="playMedicine" id="playMedicine" ng-model="moldPlay.medicine" min="0" max="6" tabindex="27" placeholder="0" required/></p>
            <p><label for="playMelee"><b>Melee:</b></label><input type="number" name="playMelee" id="playMelee" ng-model="moldPlay.melee" min="0" max="6" tabindex="28" placeholder="0" required/></p>
            <p><label for="playNego"><b>Negotiation:</b></label><input type="number" name="playNego" id="playNego" ng-model="moldPlay.negotiation" min="0" max="6" tabindex="29" placeholder="0" required/></p>
            <p><label for="playOuter"><b>Knowledge (Outer Rim):</b></label><input type="number" name="playOuter" id="playOuter" ng-model="moldPlay.outer_rim" min="0" max="6" tabindex="30" placeholder="0" required/></p>
            <p><label for="playPerception"><b>Perception:</b></label><input type="number" name="playPerception" id="playPerception" ng-model="moldPlay.perception" min="0" max="6" tabindex="31" placeholder="0" required/></p>
            <p><label for="playPilotP"><b>Piloting (Planetary):</b></label><input type="number" name="playPilotP" id="playPilotP" ng-model="moldPlay.piloting_p" min="0" max="6" tabindex="32" placeholder="0" required/></p>
            <p><label for="playPilotS"><b>Piloting (Space):</b></label><input type="number" name="playPilotS" id="playPilotS" ng-model="moldPlay.piloting_s" min="0" max="6" tabindex="33" placeholder="0" required/></p>
            <p><label for="playRangedH"><b>Ranged (Heavy):</b></label><input type="number" name="playRangedH" id="playRangedH" ng-model="moldPlay.ranged_h" min="0" max="6" tabindex="34" placeholder="0" required/></p>
            <p><label for="playRangedL"><b>Ranged (Light):</b></label><input type="number" name="playRangedL" id="playRangedL" ng-model="moldPlay.ranged_l" min="0" max="6" tabindex="35" placeholder="0" required/></p>
            <p><label for="playResil"><b>Resilience:</b></label><input type="number" name="playResil" id="playResil" ng-model="moldPlay.resilience" min="0" max="6" tabindex="36" placeholder="0" required/></p>
            <p><label for="playSkul"><b>Skulduggery:</b></label><input type="number" name="playSkul" id="playSkul" ng-model="moldPlay.skulduggery" min="0" max="6" tabindex="37" placeholder="0" required/></p>
            <p><label for="playStealth"><b>Stealth:</b></label><input type="number" name="playStealth" id="playStealth" ng-model="moldPlay.stealth" min="0" max="6" tabindex="38" placeholder="0" required/></p>
            <p><label for="playStreet"><b>Streetwise:</b></label><input type="number" name="playStreet" id="playStreet" ng-model="moldPlay.streetwise" min="0" max="6" tabindex="39" placeholder="0" required/></p>
            <p><label for="playSurvival"><b>Survival:</b></label><input type="number" name="playSurvival" id="playSurvival" ng-model="moldPlay.survival" min="0" max="6" tabindex="40" placeholder="0" required/></p>
            <p><label for="playUnder"><b>Knowledge (Underworld):</b></label><input type="number" name="playUnder" id="playUnder" ng-model="moldPlay.underworld" min="0" max="6" tabindex="41" placeholder="0" required/></p>
            <p><label for="playVigil"><b>Vigilance:</b></label><input type="number" name="playVigil" id="playVigil" ng-model="moldPlay.vigilance" min="0" max="6" tabindex="42" placeholder="0" required/></p>
            <p><label for="playWarfare"><b>Knowledge (Warfare):</b></label><input type="number" name="playWarfare" id="playWarfare" ng-model="moldPlay.warfare" min="0" max="6" tabindex="43" placeholder="0" required/></p>
            <p><label for="playXenology"><b>Knowledge (Xenology):</b></label><input type="number" name="playXenology" id="playXenology" ng-model="moldPlay.xenology" min="0" max="6" tabindex="44" placeholder="0" required/></p>
            <button ng-show="playAddForm.$valid" ng-click="mCont.AddPlay()" class="menu_p">Add</button>
        </form>
    </div>
</div>
