<div ng-show="mCont.ShowTab(3)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Specializations</h2>
            <div style="overflow: auto; height: 61vh;">
                <ul>
				    <li ng-repeat="(ind, specialization) in specializations">
					    <span class="clickable">
                            {{"{{specialization.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page">
        <form id="specialAddForm" name="specialAddForm" novalidate>
            <p><label><b>Specialization Name:</b></label><input type="text" name="specName" id="specName" ng-model="moldSpecial.name" required/></p>
            <p><label><b>Subtitle:</b></label><input type="text" name="specSubtitle" ng-model="moldSpecial.subtitle" /></p>
            <p><label><b>Skill Slots:</b></label><input type="number" name="specSkillSlots" ng-model="moldSpecial.skill_slots" max="4" min="3" required/></p>
            <p><label><b>Career:</b></label><select name="specCareer" ng-model="moldSpecial.career.career_id" ng-options="career.career_id as career.name for career in careers" class="sing_select" required>
                <option value="" selected>Select Career</option>
            </select></p>
            <p><label><b>Skills:</b></label><select name="specSkills" data-ng-attr-size="{{"{{skills.length}}"}}" style="max-height: 20vh;" ng-model="moldSpecial.skills" ng-options="skill.skill_id as skill.name for skill in skills" multiple required></select></p>
            <button ng-show="specialAddForm.$valid" ng-click="mCont.AddSpecialization()" class="next_butt">Save</button>
        </form>
    </div>
</div>
