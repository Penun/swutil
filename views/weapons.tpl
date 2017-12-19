<div ng-show="mCont.ShowTab(3)" class="sixty_he fade_in">
    <div class="left_page_col fade_in mobCol" id="left_col_w">
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
    <div class="left_page_col mid_col fade_in mobCol unexposed" id="mid_col_w" ng-show="curWeapType.sub_types != null">
        <div class="mobOnly"><h3>{{"{{curWeapType.type_name}}"}}</h3><button type="button" ng-click="mCont.BackToLeftWeap()" class="closeButton">Back</button></div>
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
    <div class="right_col mobCol unexposed fade_in" id="right_col_w" ng-show="curWeapSub != null">
        <div class="mobOnly"><h3>{{"{{curWeapSub.type_name}}"}}</h3><button type="button" ng-click="mCont.BackToMidWeap()" class="closeButton">Back</button></div>
        <div>
            <table class="sw_back">
                <tr>
                    <th class="tablePadT" ng-click="mCont.SortList(curWeapSub.weapons, 'name', 'weNa')">Name</th>
                    <th class="tablePadT" ng-click="mCont.SortList(curWeapSub.weapons, 'rarity', 'weRa')">Rarity</th>
                    <th class="tablePadT" ng-click="mCont.SortList(curWeapSub.weapons, 'damage', 'weDa')">Damage</th>
                    <th class="tablePadT" ng-click="mCont.SortList(curWeapSub.weapons, 'critical', 'weCr')">Critical</th>
                    <th class="tablePadT" ng-click="mCont.SortList(curWeapSub.weapons, 'range', 'weRa')">Range</th>
                </tr>
                <tr ng-repeat="(ind, weap) in curWeapSub.weapons" ng-click="mCont.RevealWeapon(ind)" class="item">
                    <td class="tablePad">{{"{{weap.name}}"}}</td>
                    <td class="rang"><span style="float: none;" ng-if="weap.restricted">(R)</span> {{"{{weap.rarity}}"}}</td>
                    <td class="rang"><span style="float: none;" ng-if="weap.damage_add">+</span>{{"{{weap.damage}}"}}</td>
                    <td class="rang">{{"{{weap.critical}}"}}</td>
                    <td class="rang">{{"{{weap.range}}"}}</td>
                </tr>
            </table>
            <div class="sw_back_s talentPanelOut fade_in" ng-show="curWeap != null">
                <button type="button" ng-click="mCont.CloseWeapon()" class="closeButton">X</button>
                <div class="talentPanel">
                    <div class="characterBlock"><b>{{"{{curWeap.name}}"}}</b></div>
                    <div class="characterBlock">Skill: {{"{{skills[curWeap.skill_ind].name}}"}}</div>
                    <div class="characterBlock">Damage: <span style="float: none;" ng-if="curWeap.damage_add">+</span>{{"{{curWeap.damage}}"}}</div>
                    <div class="characterBlock">Critical: {{"{{curWeap.critical}}"}}</div>
                    <div class="characterBlock">Range: {{"{{curWeap.range}}"}}</div>
                    <div class="characterBlock">Encumbrance: {{"{{curWeap.encumbrance}}"}}</div>
                    <div class="characterBlock">Hard Points: {{"{{curWeap.hard_points}}"}}</div>
                    <div class="characterBlock">Price: <span style="float: none;" ng-if="curWeap.restricted">(R)</span> {{"{{curWeap.price}}"}}</div>
                    <div class="characterBlock">Rarity: {{"{{curWeap.rarity}}"}}</div>
                    <div class="characterBlock" ng-show="curWeap.special != ''">Special: {{"{{curWeap.special}}"}}</div>
                    <div ng-bind-html="curWeap.description" class="taleDesc"></div>
                </div>
            </div>
        </div>
    </div>
</div>
