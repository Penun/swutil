<div ng-show="mCont.ShowTab(1)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Species</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, spec) in species">
					    <span class="clickable">
                            {{"{{spec.name}} - {{spec.ref_page}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page">
        <form id="specAddForm" name="specAddForm" novalidate>
            <p><label><b>Species Name:</b></label><input type="text" name="specName" id="specName" ng-model="moldSpecies.name" ng-change="mCont.CheckSpec()" autofocus required/></p>
            <p><label><b>Reference Page:</b></label><input type="text" name="ref_page" placeholder="Reference Page" ng-model="moldSpecies.ref_page" required/></p>
            <div class="characterBlock">
                <span><b>Br</b></span>
                <span><b>Ag</b></span>
                <span><b>In</b></span>
                <span><b>Cu</b></span>
                <span><b>Wi</b></span>
                <span><b>Pr</b></span>
            </div>
            <div class="characterBlock">
                <span><input type="number" name="brawnIn" max="4" min="1" placeholder="0" ng-model="moldSpecies.brawn"  required/></span>
                <span><input type="number" name="agilityIn" max="4" min="1" placeholder="0" ng-model="moldSpecies.agility"  required/></span>
                <span><input type="number" name="intellectIn" max="4" min="1" placeholder="0" ng-model="moldSpecies.intellect"  required/></span>
                <span><input type="number" name="cunningIn" max="4" min="1" placeholder="0" ng-model="moldSpecies.cunning"  required/></span>
                <span><input type="number" name="willpowerIn" max="4" min="1" placeholder="0" ng-model="moldSpecies.willpower"  required/></span>
                <span><input type="number" name="presenceIn" max="4" min="1" placeholder="0" ng-model="moldSpecies.presence"  required/></span>
            </div>
                <p><span class="left_label"><label><b>Wound Threshold:</b></label></span><input type="number" name="woundThresh" max="15" min="6" placeholder="0" ng-model="moldSpecies.wound_threshold"  required/></p>
                <p><span class="left_label"><label><b>Strain Threshold:</b></label></span><input type="number" name="strainThresh" max="15" min="6" placeholder="0" ng-model="moldSpecies.strain_threshold"  required/></p>
                <p><span class="left_label"><label><b>Starting XP:</b></label></span><input type="number" name="startingXp" max="250" min="50" placeholder="0" step="5" ng-model="moldSpecies.starting_xp"  required/></p>
            <div class="abilities">
                <label><b>Traits:</b></label>
                <textarea name="abilAdd" id="abilAdd" rows="5"></textarea>
                <button type="button" ng-click="mCont.AddAbility()">Add Ability</button>
                <ul class="specAbil topped">
                    <li ng-repeat="(ind, attrib) in moldSpecies.attributes">
                        <span>{{"{{attrib.description}}"}}</span>
                    </li>
                </ul>
            </div>
            <button ng-show="specAddForm.$valid && moldSpecies.attributes.length > 0" ng-click="mCont.AddSpecies()" class="next_butt">Save</button>
        </form>
    </div>
</div>
