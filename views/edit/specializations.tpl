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
            <p><label><b>Specialization Name:</b></label><input type="text" name="specialName" id="specialName" ng-model="moldSpecial.name" required/></p>
            <p><label><b>Subtitle:</b></label><input type="text" name="specSubtitle" ng-model="moldSpecial.subtitle" /></p>
            <p><label><b>Skill Slots:</b></label><input type="number" name="specSkillSlots" ng-model="moldSpecial.skill_slots" max="2" min="2" required/></p>
            <p><label><b>Career:</b></label><select name="specCareer" ng-model="moldSpecial.careers" ng-options="career.id as career.name for career in careers" data-ng-attr-size="{{"{{careers.length}}"}}" style="max-height: 20vh;" multiple required></select></p>
            <br />
            <p><label><b>Skills:</b></label><select name="specSkills" data-ng-attr-size="{{"{{skills.length}}"}}" style="max-height: 20vh;" ng-model="moldSpecial.skills" ng-options="skill.id as skill.name for skill in skills" multiple required></select></p>
            <br />
            <p>
                <select ng-model="moldSpecial.talents[0].talent.id" name="talSel_1_1" class="talent" ng-options="talent.id as talent.name for talent in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_1_1" style="visibility: hidden;" />
                <select ng-model="moldSpecial.talents[1].talent.id" name="talSel_1_2" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_1_2" style="visibility: hidden;" />
                <select ng-model="moldSpecial.talents[2].talent.id" name="talSel_1_3" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_1_3" style="visibility: hidden;" />
                <select ng-model="moldSpecial.talents[3].talent.id" name="talSel_1_4" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
            </p>
            <p>
                <div class="talent"><input type="checkbox" name="talConnD_1_1" ng-model="moldSpecial.talents[0].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_1_2" ng-model="moldSpecial.talents[1].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_1_3" ng-model="moldSpecial.talents[2].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_1_4" ng-model="moldSpecial.talents[3].down" /></div>
            </p>
            <p>
                <select ng-model="moldSpecial.talents[4].talent.id" name="talSel_2_1" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_2_1" ng-model="moldSpecial.talents[4].right" />
                <select ng-model="moldSpecial.talents[5].talent.id" name="talSel_2_2" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_2_2" ng-model="moldSpecial.talents[5].right" />
                <select ng-model="moldSpecial.talents[6].talent.id" name="talSel_2_3" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_2_3" ng-model="moldSpecial.talents[6].right" />
                <select ng-model="moldSpecial.talents[7].talent.id" name="talSel_2_4" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
            </p>
            <p>
                <div class="talent"><input type="checkbox" name="talConnD_2_1" ng-model="moldSpecial.talents[4].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_2_2" ng-model="moldSpecial.talents[5].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_2_3" ng-model="moldSpecial.talents[6].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_2_4" ng-model="moldSpecial.talents[7].down" /></div>
            </p>
            <p>
                <select ng-model="moldSpecial.talents[8].talent.id" name="talSel_3_1" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_3_1" ng-model="moldSpecial.talents[8].right" />
                <select ng-model="moldSpecial.talents[9].talent.id" name="talSel_3_2" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_3_2" ng-model="moldSpecial.talents[9].right" />
                <select ng-model="moldSpecial.talents[10].talent.id" name="talSel_3_3" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_3_3" ng-model="moldSpecial.talents[10].right" />
                <select ng-model="moldSpecial.talents[11].talent.id" name="talSel_3_4" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
            </p>
            <p>
                <div class="talent"><input type="checkbox" name="talConnD_3_1" ng-model="moldSpecial.talents[8].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_3_2" ng-model="moldSpecial.talents[9].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_3_3" ng-model="moldSpecial.talents[10].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_3_4" ng-model="moldSpecial.talents[11].down" /></div>
            </p>
            <p>
                <select ng-model="moldSpecial.talents[12].talent.id" name="talSel_4_1" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_4_1" ng-model="moldSpecial.talents[12].right" />
                <select ng-model="moldSpecial.talents[13].talent.id" name="talSel_4_2" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_4_2" ng-model="moldSpecial.talents[13].right" />
                <select ng-model="moldSpecial.talents[14].talent.id" name="talSel_4_3" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_4_3" ng-model="moldSpecial.talents[14].right" />
                <select ng-model="moldSpecial.talents[15].talent.id" name="talSel_4_4" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
            </p>
            <p>
                <div class="talent"><input type="checkbox" name="talConnD_4_1" ng-model="moldSpecial.talents[12].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_4_2" ng-model="moldSpecial.talents[13].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_4_3" ng-model="moldSpecial.talents[14].down" /></div>
                <div class="talent"><input type="checkbox" name="talConnD_4_4" ng-model="moldSpecial.talents[15].down" /></div>
            </p>
            <p>
                <select ng-model="moldSpecial.talents[16].talent.id" name="talSel_5_1" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_5_1" ng-model="moldSpecial.talents[16].right" />
                <select ng-model="moldSpecial.talents[17].talent.id" name="talSel_5_2" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_5_2" ng-model="moldSpecial.talents[17].right" />
                <select ng-model="moldSpecial.talents[18].talent.id" name="talSel_5_3" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
                <input type="checkbox" name="talConnR_5_3" ng-model="moldSpecial.talents[18].right" />
                <select ng-model="moldSpecial.talents[19].talent.id" name="talSel_5_4" class="talent" ng-options="tal.id as tal.name for tal in talents" required>
                    <option value="">Select Talent</option>
                </select>
            </p>
            <button ng-show="specialAddForm.$valid" ng-click="mCont.AddSpecialization()" class="next_butt">Save</button>
        </form>
    </div>
</div>
