<div ng-show="mCont.ShowTab(1)" class="sixty_he fade_in">
    <div class="tablePage">
        <div class="tabPag_inner">
            <table>
                <tr class="bg_none">
                    <td colspan="4" class="table_name">Species</td>
                </tr>
                <tr>
                    <th ng-click="mCont.SortList(species, 'name', 'spNa')">Name</th>
                    <th ng-click="mCont.SortList(species, 'brawn', 'spBr')">Br</th>
                    <th ng-click="mCont.SortList(species, 'agility', 'spAg')">Ag</th>
                    <th ng-click="mCont.SortList(species, 'intellect', 'spIn')">In</th>
                    <th ng-click="mCont.SortList(species, 'cunning', 'spCu')">Cu</th>
                    <th ng-click="mCont.SortList(species, 'willpower', 'spWi')">Wi</th>
                    <th ng-click="mCont.SortList(species, 'presence', 'spPr')">Pr</th>
                    <th ng-click="mCont.SortList(species, 'wound_threshold', 'spWt')">Wound Threshold</th>
                    <th ng-click="mCont.SortList(species, 'strain_threshold', 'spSt')">Strain Threshold</th>
                    <th ng-click="mCont.SortList(species, 'starting_xp', 'spSx')">Starting XP</th>
                </tr>
                <tr ng-repeat="(ind, spec) in species" ng-click="mCont.RevealSpecies(ind)" class="item">
                    <td>{{"{{spec.name}}"}}</td>
                    <td class="rang">{{"{{spec.brawn}}"}}</td>
                    <td class="rang">{{"{{spec.agility}}"}}</td>
                    <td class="rang">{{"{{spec.intellect}}"}}</td>
                    <td class="rang">{{"{{spec.cunning}}"}}</td>
                    <td class="rang">{{"{{spec.willpower}}"}}</td>
                    <td class="rang">{{"{{spec.presence}}"}}</td>
                    <td class="rang">{{"{{spec.wound_threshold}}"}}</td>
                    <td class="rang">{{"{{spec.strain_threshold}}"}}</td>
                    <td class="rang">{{"{{spec.starting_xp}}"}}</td>
                </tr>
            </table>
            <div class="sw_back_s talentPanelOut" ng-show="curSpec != null">
                <div class="talentPanel">
                    {{str2html rawImg}}
                    <h1>{{"{{curSpec.name}}"}}</h1><button type="button" ng-click="mCont.CloseSpecies()" style="font-size: 0.5em; position: absolute; right: 25px;">X</button>
                    <div class="characterBlock">
                        <span><b>Br</b></span>
                        <span><b>Ag</b></span>
                        <span><b>In</b></span>
                        <span><b>Cu</b></span>
                        <span><b>Wi</b></span>
                        <span><b>Pr</b></span>
                    </div>
                    <div class="characterBlock">
                        <span>{{"{{curSpec.brawn}}"}}</span>
                        <span>{{"{{curSpec.agility}}"}}</span>
                        <span>{{"{{curSpec.intellect}}"}}</span>
                        <span>{{"{{curSpec.cunning}}"}}</span>
                        <span>{{"{{curSpec.willpower}}"}}</span>
                        <span>{{"{{curSpec.presence}}"}}</span>
                    </div>
                    <div class="characterBlock">
                        <b>Wound Threshold:</b> {{"{{curSpec.wound_threshold}}"}} + Brawn
                    </div>
                    <div class="characterBlock">
                        <b>Strain Threshold:</b> {{"{{curSpec.strain_threshold}}"}} + Willpower
                    </div>
                    <div class="characterBlock">
                        <b>Starting XP:</b> {{"{{curSpec.starting_xp}}"}}
                    </div>
                    <div>
                        <ul class="specAbil">
                            <li ng-repeat="(ind, attrib) in curSpec.attributes">
                                <span ng-bind-html="attrib.description" class="taleDesc"></span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
