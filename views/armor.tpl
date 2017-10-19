<div ng-show="mCont.ShowTab(4)" class="sixty_he fade_in">
    <div class="tablePage">
        <div class="tabPag_inner">
            <table>
                <tr class="bg_none">
                    <td colspan="4" class="table_name">Armor</td>
                </tr>
                <tr>
                    <th ng-click="mCont.SortList(armor, 'type', 'arTy')">Type</th>
                    <th ng-click="mCont.SortList(armor, 'defense', 'arDe')">Def</th>
                    <th ng-click="mCont.SortList(armor, 'soak', 'arSo')">Soak</th>
                    <th ng-click="mCont.SortList(armor, 'hard_points', 'arHp')">HP</th>
                </tr>
                <tr ng-repeat="(ind, arm) in armor" ng-click="mCont.RevealArmor(ind)" class="item">
                    <td>{{"{{arm.type}}"}}</td>
                    <td class="rang">{{"{{arm.defense}}"}}</td>
                    <td class="rang">{{"{{arm.soak}}"}}</td>
                    <td class="rang">{{"{{arm.hard_points}}"}}</td>
                </tr>
            </table>
            <div class="sw_back_s talentPanelOut" ng-show="curArmor != null">
                <div class="talentPanel">
                    <div class="characterBlock"><b>{{"{{curArmor.type}}"}}</b><button type="button" ng-click="mCont.CloseArmor()" style="font-size: 0.5em; position: absolute; right: 15px;">X</button></div>
                    <div class="characterBlock">Defense: {{"{{curArmor.defense}}"}}</div>
                    <div class="characterBlock">Soak: {{"{{curArmor.soak}}"}}</div>
                    <div class="characterBlock">Price: <span style="float: none;" ng-if="curArmor.restricted">(R)</span> {{"{{curArmor.price}}"}}</div>
                    <div class="characterBlock">Encumbrance: {{"{{curArmor.encumbrance}}"}}</div>
                    <div class="characterBlock">Hard Points: {{"{{curArmor.hard_points}}"}}</div>
                    <div class="characterBlock">Rarity: {{"{{curArmor.rarity}}"}}</div>
                    <div ng-bind-html="curArmor.description" class="taleDesc"></div>
                </div>
            </div>
        </div>
    </div>
</div>
