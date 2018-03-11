<div ng-show="mCont.ShowTab(3)" class="sixty_he">
    <div class="tripPage">
        <div class="gridCol fade_in mobCol oThirdLCol colHigh" id="left_col_w">
            <h2 class="gridRow h2">Weapon Types</h2>
            <div class="gridRow2 innerCol">
				    <span ng-click="mCont.RevealWeaponType(ind)" ng-repeat="(ind, weap) in weapons" class="clickable">
                        {{"{{weap.type_name}}"}}
				    </span>
			    </ul>
            </div>
        </div>
        <div class="gridCol2 fade_in mobCol unexposed oThirdMCol colHigh" id="mid_col_w" ng-show="curWeapType.sub_types != null">
            <div class="mobOnly"><h3>{{"{{curWeapType.type_name}}"}}</h3><button type="button" ng-click="mCont.BackToLeftWeap()" class="closeButton">Back</button></div>
            <h2 class="gridRow h2">Weapon Sub-Types</h2>
            <div class="innerCol gridRow2">
			    <span ng-repeat="(ind, subTy) in curWeapType.sub_types" ng-click="mCont.RevealWeapons(ind)" class="clickable alCenter">
                    {{"{{subTy.type_name}}"}}
			    </span>
            </div>
        </div>
        <div class=" gridCol3 right_col mobCol unexposed fade_in" id="right_col_w" ng-show="curWeapSub != null">
            <div class="mobOnly"><h3>{{"{{curWeapSub.type_name}}"}}</h3><button type="button" ng-click="mCont.BackToMidWeap()" class="closeButton">Back</button></div>
            <div class="wepTab sw_back">
                <div class="gridRow gridCol weapHeadTab">
                    <span class="th_head gridRow wh_col_span"></span>
                    <span class="th_table_name gridRow wh_col_span alCenter">{{"{{curWeapSub.type_name}}"}}</span>
                    <span class="th_head gridRow2 wh_col_span"></span>
                    <span class="gridCol gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(curWeapSub.weapons, 'name', 'weNa')">Name</span>
                    <span class="gridCol2 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(curWeapSub.weapons, 'rarity', 'weRa')">Rarity</span>
                    <span class="gridCol3 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(curWeapSub.weapons, 'damage', 'weDa')">Damage</span>
                    <span class="gridCol4 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(curWeapSub.weapons, 'critical', 'weCr')">Critical</span>
                    <span class="gridCol5 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(curWeapSub.weapons, 'range', 'weRa')">Range</span>
                </div>
                <div class="gridRow2 gridCol weapFoll">
                    <div ng-repeat="(ind, weap) in curWeapSub.weapons" ng-click="mCont.RevealWeapon(ind)" class="weapSubTab wh_item">
                        <span class="weapPadL gridCol">{{"{{weap.name}}"}}</span>
                        <span class="gridCol2 alCenter"><span style="float: none;" ng-if="weap.restricted">(R)</span> {{"{{weap.rarity}}"}}</span>
                        <span class="gridCol3 alCenter"><span style="float: none;" ng-if="weap.damage_add">+</span>{{"{{weap.damage}}"}}</span>
                        <span class="gridCol4 alCenter"><span style="float: none;" ng-if="weap.critical == 0">-</span><span style="float: none;" ng-if="weap.critical >= 1">{{"{{weap.critical}}"}}</span></span>
                        <span class="gridCol5 alCenter">{{"{{weap.range}}"}}</span>
                    </div>
                </div>
                <div class="sw_back_s talPaOut fade_in" ng-show="curWeap != null">
                    <div class="talentPanel">
                        <button type="button" ng-click="mCont.CloseWeapon()" class="closeButton">X</button>
                        <div class="gridCol h2"><b>{{"{{curWeap.name}}"}}</b></div>
                        <div class="gridCol">Skill: {{"{{skills[curWeap.skill_ind].name}}"}}</div>
                        <div class="gridCol">Damage: <span style="float: none;" ng-if="curWeap.damage_add">+</span>{{"{{curWeap.damage}}"}}</div>
                        <div class="gridCol">Critical: <span style="float: none;" ng-if="curWeap.critical == 0">-</span><span style="float: none;" ng-if="curWeap.critical >= 1">{{"{{curWeap.critical}}"}}</span></div>
                        <div class="gridCol">Range: {{"{{curWeap.range}}"}}</div>
                        <div class="gridCol">Encumbrance: {{"{{curWeap.encumbrance}}"}}</div>
                        <div class="gridCol">Hard Points: {{"{{curWeap.hard_points}}"}}</div>
                        <div class="gridCol">Price: <span style="float: none;" ng-if="curWeap.restricted">(R)</span> {{"{{curWeap.price}}"}}</div>
                        <div class="gridCol">Rarity: {{"{{curWeap.rarity}}"}}</div>
                        <div class="gridCol" ng-show="curWeap.special != ''">Special: {{"{{curWeap.special}}"}}</div>
                        <div ng-bind-html="curWeap.description" class="spanTwoCol taleDesc"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
