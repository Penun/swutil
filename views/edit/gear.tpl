<div ng-show="mCont.ShowTab(6)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Gear</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, item) in gear">
					    <span class="clickable">
                            {{"{{item.item}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page right_page_form">
        <form id="gearAddForm" name="gearAddForm" novalidate>
            <p><label><b>Item:</b></label><input type="text" name="gearItem" id="gearItem" ng-model="moldGear.item" ng-change="mCont.CheckGear()" required/></p>
            <p><label><b>Type:</b></label><select name="gearType" ng-model="moldGear.type" class="sing_select" required>
                <option value="Communications Equipment">Communications Equipment</option>
                <option value="Poisons and Drugs">Poisons and Drugs</option>
                <option value="Scanning and Surveillance Equipment (Detection Devices)">Scanning and Surveillance Equipment (Detection Devices)</option>
                <option value="Medical Equipment">Medical Equipment</option>
                <option value="Cybernetic Enhancements and Replacements">Cybernetic Enhancements and Replacements</option>
                <option value="Recreational Entertainment">Recreational Entertainment</option>
                <option value="Infiltration and Espionage Equipment (Security)">Infiltration and Espionage Equipment (Security)</option>
                <option value="Survival Gear">Survival Gear</option>
                <option value="Tools and Electronics">Tools and Electronics</option>
                <option value="Black Market">Black Market</option>
                <option value="Load Bearing, Carrying, and Storage Equipment">Load Bearing, Carrying, and Storage Equipment</option>
                <option value="Droids">Droids</option>
                <option value="Slicing Tools">Slicing Tools</option>
                <option value="Construction and Salvage Tools">Construction and Salvage Tools</option>
                <option value="Remotes">Remotes</option>
            </select></p>
            <p><label><b>Price:</b></label><input type="number" name="gearPrice" ng-model="moldGear.price" min="0" required/></p>
            <p><label><b>Restricted:</b></label><input type="checkbox" name="gearRestricted" ng-model="moldGear.restricted" /></p>
            <p><label><b>Encumbrance:</b></label><input type="number" name="gearEcum" ng-model="moldGear.encumbrance" min="0" max="99" required/></p>
            <p><label><b>Rarity:</b></label><input type="number" name="gearRarity" ng-model="moldGear.rarity" min="0" max="99" required/></p>
            <div class="abilities"><label><b>Description:</b></label><textarea name="gearDesc" ng-model="moldGear.description" rows="5"></textarea></div>
            <button ng-show="gearAddForm.$valid" ng-click="mCont.AddGear()" class="next_butt">Save</button>
        </form>
    </div>
</div>
