<div ng-show="mCont.ShowTab(2)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Talents</h2>
            <div style="overflow: auto; height: 61vh;">
                <ul>
				    <li ng-repeat="(ind, talent) in talents">
					    <span class="clickable">
                            {{"{{talent.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page">
        <form id="talentAddForm" name="talentAddForm" novalidate>
            <p><label><b>Talent Name:</b></label><input type="text" name="talName" id="talName" ng-model="moldTalent.name" ng-change="mCont.CheckTal()" required/></p>
            <p><label><b>Type:</b></label><select name="talType" ng-model="moldTalent.type" class="sing_select">
                <option value="Incidental">Incidental</option>
                <option value="Maneuver">Maneuver</option>
                <option value="Action">Action</option>
                <option value="Passive" selected>Passive</option>
            </select></p>
            <p><label><b>Ranked:</b></label><input type="checkbox" name="talRanked" ng-model="moldTalent.ranked" /></p>
            <div class="abilities"><textarea name="telDesc" ng-model="moldTalent.description" rows="5" required></textarea></div>
            <button ng-show="talentAddForm.$valid" ng-click="mCont.AddTalent()" class="next_butt">Save</button>
        </form>
    </div>
</div>
