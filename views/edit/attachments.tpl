<div ng-show="mCont.ShowTab(7)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Attachments</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, atta) in attachments">
                        <span class="clickable">
                            {{"{{atta.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page right_page_form">
        <form id="attaAddForm" name="attaAddForm" novalidate>
            <p><label><b>Attachment:</b></label><input type="text" name="attaName" id="attaName" ng-model="moldAtta.name" ng-change="mCont.CheckAtta()" required/></p>
            <p><label><b>Type:</b></label><select name="attaType" ng-model="moldAtta.type" class="sing_select" required>
                <option value="Weapon">Weapon</option>
                <option value="Armor">Armor</option>
            </select></p>
            <p><label><b>Price:</b></label><input type="number" name="attaPrice" ng-model="moldAtta.price" min="0" step="10" required/></p>
            <p><label><b>Restricted:</b></label><input type="checkbox" name="attaRestricted" ng-model="moldAtta.restricted" /></p>
            <p><label><b>Encumbrance:</b></label><input type="number" name="attaEcum" ng-model="moldAtta.encumbrance" min="0" max="99" /></p>
            <p><label><b>HP Required:</b></label><input type="number" name="attaHpReq" ng-model="moldAtta.hp_required" min="0" max="9" required/></p>
            <p><label><b>Rarity:</b></label><input type="number" name="attaRarity" ng-model="moldAtta.rarity" min="0" max="99" required/></p>
            <div class="abilities"><label><b>Description:</b></label><textarea name="attaDesc" ng-model="moldAtta.description" rows="5"></textarea></div>
            <button ng-show="attaAddForm.$valid" ng-click="mCont.AddAtta()" class="next_butt">Save</button>
        </form>
    </div>
</div>
