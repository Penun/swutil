<div ng-show="mCont.ShowTab(5)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Armor</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, arm) in armor">
					    <span class="clickable">
                            {{"{{arm.type}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page right_page_form">
        <form id="armorAddForm" name="armorAddForm" novalidate>
            <p><label><b>Armor Type:</b></label><input type="text" name="armType" id="armType" ng-model="moldArmor.type" ng-change="mCont.CheckArm()" required/></p>
            <p><label><b>Defense:</b></label><input type="number" name="armDefense" ng-model="moldArmor.defense" min="0" max="9" required/></p>
            <p><label><b>Soak:</b></label><input type="number" name="armSoak" ng-model="moldArmor.soak" min="0" max="9" required/></p>
            <p><label><b>Price:</b></label><input type="number" name="armPrice" ng-model="moldArmor.price" min="0" required/></p>
            <p><label><b>Restricted:</b></label><input type="checkbox" name="armRestricted" ng-model="moldArmor.restricted" /></p>
            <p><label><b>Encumbrance:</b></label><input type="number" name="armEcum" ng-model="moldArmor.encumbrance" min="0" max="9" required/></p>
            <p><label><b>Hard Points:</b></label><input type="number" name="armHardP" ng-model="moldArmor.hard_points" min="0" max="9" required/></p>
            <p><label><b>Rarity:</b></label><input type="number" name="armRarity" ng-model="moldArmor.rarity" min="0" max="99" required/></p>
            <div class="abilities"><label><b>Description:</b></label><textarea name="armDesc" ng-model="moldArmor.description" rows="5"></textarea></div>
            <button ng-show="armorAddForm.$valid" ng-click="mCont.AddArmor()" class="next_butt">Save</button>
        </form>
    </div>
</div>
