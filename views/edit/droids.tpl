<div ng-show="mCont.ShowTab(8)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Droids</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, droid) in droids">
					    <span class="clickable">
                            {{"{{droid.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page right_page_form">
        <form id="droidAddForm" name="droidAddForm" novalidate>
            <p><label><b>Name:</b></label><input type="text" name="droiName" id="droidName" ng-model="moldDroid.name" ng-change="mCont.CheckDroid()" required/></p>
            <p><label><b>Price:</b></label><input type="number" name="droidPrice" ng-model="moldDroid.price" min="0" step="10" required/></p>
            <p><label><b>Restricted:</b></label><input type="checkbox" name="droidRestricted" ng-model="moldDroid.restricted" /></p>
            <p><label><b>Rarity:</b></label><input type="number" name="droidRarity" ng-model="moldDroid.rarity" placeholder="1" min="1" max="9" required/></p>
            <div class="characterBlock">
                <span><b>Br</b></span>
                <span><b>Ag</b></span>
                <span><b>In</b></span>
                <span><b>Cu</b></span>
                <span><b>Wi</b></span>
                <span><b>Pr</b></span>
            </div>
            <div class="characterBlock">
                <span><input type="number" name="brawnIn" max="6" min="1" placeholder="0" ng-model="moldDroid.brawn" required/></span>
                <span><input type="number" name="agilityIn" max="6" min="1" placeholder="0" ng-model="moldDroid.agility" required/></span>
                <span><input type="number" name="intellectIn" max="6" min="1" placeholder="0" ng-model="moldDroid.intellect" required/></span>
                <span><input type="number" name="cunningIn" max="6" min="1" placeholder="0" ng-model="moldDroid.cunning" required/></span>
                <span><input type="number" name="willpowerIn" max="6" min="1" placeholder="0" ng-model="moldDroid.willpower" required/></span>
                <span><input type="number" name="presenceIn" max="6" min="1" placeholder="0" ng-model="moldDroid.presence" required/></span>
            </div>
            <p><label><b>Wound Threshold:</b></label><input type="number" name="droiWoThre" placeholder="0" min="0" max="30" ng-model="moldDroid.wound_threshold" required/></p>
            <p><label><b>Soak Value:</b></label><input type="number" name="soakValue" placeholder="0" min="0" max="9" ng-model="moldDroid.soak_value" required/></p>
            <p><label><b>Defense Melee:</b></label><input type="number" name="defMele" placeholder="0" min="0" max="9" ng-model="moldDroid.defense_melee" required/></p>
            <p><label><b>Defense Range:</b></label><input type="number" name="defRang" placeholder="0" min="0" max="9" ng-model="moldDroid.defense_ranged" required/></p>
            <br />
            <div class="abilities">
                <label><b>Skills:</b></label>
                <select name="droidSkills" data-ng-attr-size="{{"{{skills.length}}"}}" style="max-height: 20vh;" ng-model="mCont.skillsCho" ng-options="skill.id as skill.name for skill in skills" multiple></select>
                <button type="button" ng-click="mCont.AddSkills()">Add Skills</button>
                <div>
                    <span class="droidSkill" ng-repeat="(ind, skill) in moldDroid.skills">
                        <label><b>{{"{{skill.name}}"}} Ranks:</b></label><input type="number" name="skiRanks" placeholder="0" min="0" max="6" ng-model="moldDroid.skills[ind].ranks" required/>
                    </span>
                </div>
            </div>
            <br />
            <div class="abilities">
                <label><b>Talents:</b></label>
                <select name="droidTals" ng-model="mCont.talCho" ng-options="talent.id as talent.name for talent in talents" class="sing_select"></select>
                <button type="button" ng-click="mCont.AddTals()">Add Talent</button>
                <div>
                    <span class="droidSkill" ng-repeat="(ind, tal) in moldDroid.talents">
                        <label><b>{{"{{tal.name}}"}} Ranks:</b></label><input type="number" name="talRanks" placeholder="0" min="0" max="6" ng-model="moldDroid.talents[ind].ranks" required/>
                    </span>
                </div>
            </div>
            <br />
            <div class="abilities"><label><b>Abilities:</b></label><textarea name="droiAbil" ng-model="moldDroid.abilities" rows="5"></textarea></div>
            <div class="abilities"><label><b>Equipment:</b></label><textarea name="droiEqui" ng-model="moldDroid.equipment" rows="5"></textarea></div>
            <div class="abilities"><label><b>Description:</b></label><textarea name="droiDesc" ng-model="moldDroid.description" rows="5"></textarea></div>
            <button ng-show="droidAddForm.$valid" ng-click="mCont.AddDroid()" class="next_butt">Save</button>
        </form>
    </div>
</div>
