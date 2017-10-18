<div ng-show="mCont.ShowTab(3)" class="sixty_he fade_in">
    <div class="left_page_col">
        <div style="width: 100%">
            <h2>Weapon Types</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, weap) in weapons">
					    <span ng-click="mCont.RevealWeaponType(ind)" class="clickable">
                            {{"{{weap.type_name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="left_page_col mid_col" ng-show="curWeapType.sub_types != null">
        <div style="width: 100%">
            <h2>Weapon Sub-Types</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, subTy) in curWeapType.sub_types">
					    <span ng-click="mCont.RevealWeapons(ind)" class="clickable">
                            {{"{{subTy.type_name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_col" id="right_col">
        <div ng-show="curWeapSub != null">
            <span ng-repeat="(ind, weap) in curWeapSub.weapons">
                {{"{{weap.name}}"}}
            </span>
        </div>
    </div>
</div>
