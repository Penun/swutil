<div ng-show="mCont.ShowTab(4)" class="sixty_he fade_in">
    <div class="tablePage">
        <div class="tabPag_inner">
            <div class="armorHead sw_back">
                <span class="th_head gridRow span5Col"></span>
                <span class="th_table_name alCenter gridRow span5Col">Armor</span>
                <span class="th_head gridRow2 span5Col"></span>
                <span class="gridRow2 gridCol alCenter th_table_name th_subTab_name sortable" ng-click="mCont.SortList(armor, 'type', 'arTy')">Type</span>
                <span class="gridRow2 gridCol2 alCenter th_table_name th_subTab_name sortable" ng-click="mCont.SortList(armor, 'rarity', 'arRa')">Rarity</span>
                <span class="gridRow2 gridCol3 alCenter th_table_name th_subTab_name sortable" ng-click="mCont.SortList(armor, 'defense', 'arDe')">Defense</span>
                <span class="gridRow2 gridCol4 alCenter th_table_name th_subTab_name sortable" ng-click="mCont.SortList(armor, 'soak', 'arSo')">Soak</span>
                <span class="gridRow2 gridCol5 alCenter th_table_name th_subTab_name sortable" ng-click="mCont.SortList(armor, 'hard_points', 'arHp')">HP</span>
            </div>
            <div class="gridRow2 gridCol weapFoll">
                <div ng-repeat="(ind, arm) in armor" ng-click="mCont.RevealArmor(ind)" class="weapSubTab wh_item">
                    <span class="weapPadL gridCol">{{"{{arm.type}}"}}</span>
                    <span class="gridCol2 alCenter">{{"{{arm.rarity}}"}}</span>
                    <span class="gridCol3 alCenter">{{"{{arm.defense}}"}}</span>
                    <span class="gridCol4 alCenter">{{"{{arm.soak}}"}}</span>
                    <span class="gridCol5 alCenter">{{"{{arm.hard_points}}"}}</span>
                </div>
            </div>
            <div class="sw_back_s talPaOut fade_in" ng-show="curArmor != null">
                <div class="talentPanel">
                    <button type="button" ng-click="mCont.CloseArmor()" class="closeButton">X</button>
                    <div class="gridCol h2"><b>{{"{{curArmor.type}}"}}</b></div>
                    <div class="gridCol">Defense: {{"{{curArmor.defense}}"}}</div>
                    <div class="gridCol">Soak: {{"{{curArmor.soak}}"}}</div>
                    <div class="gridCol">Price: <span style="float: none;" ng-if="curArmor.restricted">(R)</span> {{"{{curArmor.price}}"}}</div>
                    <div class="gridCol">Encumbrance: {{"{{curArmor.encumbrance}}"}}</div>
                    <div class="gridCol">Hard Points: {{"{{curArmor.hard_points}}"}}</div>
                    <div class="gridCol">Rarity: {{"{{curArmor.rarity}}"}}</div>
                    <div ng-bind-html="curArmor.description" class="spanTwoCol taleDesc"></div>
                </div>
            </div>
        </div>
    </div>
</div>
