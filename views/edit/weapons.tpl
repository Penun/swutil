<div ng-show="mCont.ShowTab(4)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Weapons</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, weapon) in weapons">
					    <span class="clickable">
                            {{"{{weapon.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page right_page_form">
        <form id="weaponAddForm" name="weaponAddForm" novalidate>
            <p><label><b>Weapon Name:</b></label><input type="text" name="wepName" id="wepName" ng-model="moldWeapon.name" ng-change="mCont.CheckWeapon()" required/></p>
            <p><label><b>Type:</b></label><select name="wepType" ng-model="moldWeapon.type" class="sing_select" required>
                <option value="Ranged">Ranged</option>
                <option value="Melee">Melee</option>
                <option value="Lightsaber">Lightsaber</option>
                <option value="Micro-Rockets">Micro-Rockets</option>
            </select></p>
            <p><label><b>Sub Type:</b></label><select name="wepSubType" ng-model="moldWeapon.sub_type" class="sing_select" required>
                <option value="Energy Weapons">Energy Weapons</option>
                <option value="Slugthrowers">Slugthrowers</option>
                <option value="Thrown Weapons">Thrown Weapons</option>
                <option value="Explosives and Ordnance">Explosives and Ordnance</option>
                <option value="Other Ranged Weapons">Other Ranged Weapons</option>
                <option value="Brawling Weapons">Brawling Weapons</option>
                <option value="Melee Weapons">Melee Weapons</option>
                <option value="Micro-Rockets">Micro-Rockets</option>
                <option value="Launchers">Launchers</option>
                <option value="Lightsabers">Lightsabers</option>
                <option value="Lightsaber Hilt">Lightsaber Hilt</option>
            </select></p>
            <p><label><b>Skill:</b></label><select name="weaponSkill" ng-model="moldWeapon.skill.id" class="sing_select" required>
                <option value="3">Brawl</option>
                <option value="13">Gunnery</option>
                <option value="15">Lightsaber</option>
                <option value="19">Melee</option>
                <option value="25">Ranged (Heavy)</option>
                <option value="26">Ranged (Light)</option>
            </select></p>
            <p><label><b>Damage:</b></label><input type="number" name="wepDamage" ng-model="moldWeapon.damage" min="0" max="99" required/></p>
            <p><label><b>Damage Additive:</b></label><input type="checkbox" name="wepDamAdd" ng-model="moldWeapon.damage_add" /></p>
            <p><label><b>Critical:</b></label><input type="number" name="wepCritical" ng-model="moldWeapon.critical" min="0" max="9" required/></p>
            <p><label><b>Range:</b></label><select name="wepRange" ng-model="moldWeapon.range" class="sing_select" required>
                <option value="Engaged">Engaged</option>
                <option value="Short">Short</option>
                <option value="Medium">Medium</option>
                <option value="Long">Long</option>
                <option value="Extreme">Extreme</option>
            </select></p>
            <p><label><b>Encumbrance:</b></label><input type="number" name="wepEcum" ng-model="moldWeapon.encumbrance" min="0" max="99" required/></p>
            <p><label><b>Hard Points:</b></label><input type="number" name="wepHardP" ng-model="moldWeapon.hard_points" min="0" max="9" required/></p>
            <p><label><b>Price:</b></label><input type="number" name="wepPrice" ng-model="moldWeapon.price" min="0" step="10" required/></p>
            <p><label><b>Restricted:</b></label><input type="checkbox" name="wepRestricted" ng-model="moldWeapon.restricted" /></p>
            <p><label><b>Rarity:</b></label><input type="number" name="wepRarity" ng-model="moldWeapon.rarity" min="0" max="99" required/></p>
            <div class="abilities"><label><b>Special:</b></label><textarea name="wepSpec" ng-model="moldWeapon.special" rows="5"></textarea></div>
            <div class="abilities"><label><b>Description:</b></label><textarea name="wepDesc" ng-model="moldWeapon.description" rows="5"></textarea></div>
            <button ng-show="weaponAddForm.$valid" ng-click="mCont.AddWeapon()" class="next_butt">Save</button>
        </form>
    </div>
</div>
