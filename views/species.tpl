<div ng-show="mCont.ShowTab(1)" class="sixty_he fade_in">
    <div class="tablePage">
        <div class="tabPag_inner">
            <table class="headTable sw_back">
                <tr class="head">
                    <td colspan="10" class="table_name tablePadL">Species</td>
                </tr>
                <tr class="head">
                    <th class="name rang" ng-click="mCont.SortList(species, 'name', 'spNa')">Name</th>
                    <th class="rang char" ng-click="mCont.SortList(species, 'brawn', 'spBr')">Br</th>
                    <th class="rang char" ng-click="mCont.SortList(species, 'agility', 'spAg')">Ag</th>
                    <th class="rang char" ng-click="mCont.SortList(species, 'intellect', 'spIn')">In</th>
                    <th class="rang char" ng-click="mCont.SortList(species, 'cunning', 'spCu')">Cu</th>
                    <th class="rang char" ng-click="mCont.SortList(species, 'willpower', 'spWi')">Wi</th>
                    <th class="rang char" ng-click="mCont.SortList(species, 'presence', 'spPr')">Pr</th>
                    <th class="rang char_w" ng-click="mCont.SortList(species, 'wound_threshold', 'spWt')">Wound Threshold</th>
                    <th class="rang char_w" ng-click="mCont.SortList(species, 'strain_threshold', 'spSt')">Strain Threshold</th>
                    <th class="rang char_w" ng-click="mCont.SortList(species, 'starting_xp', 'spSx')">Starting XP</th>
                </tr>
            </table>
            <div class="follTable">
                <table>
                    <tr ng-repeat="(ind, spec) in species" ng-click="mCont.RevealSpecies(ind)" class="item">
                        <td class="name">{{"{{spec.name}}"}}</td>
                        <td class="rang char">{{"{{spec.brawn}}"}}</td>
                        <td class="rang char">{{"{{spec.agility}}"}}</td>
                        <td class="rang char">{{"{{spec.intellect}}"}}</td>
                        <td class="rang char">{{"{{spec.cunning}}"}}</td>
                        <td class="rang char">{{"{{spec.willpower}}"}}</td>
                        <td class="rang char">{{"{{spec.presence}}"}}</td>
                        <td class="rang char_w">{{"{{spec.wound_threshold}}"}}</td>
                        <td class="rang char_w">{{"{{spec.strain_threshold}}"}}</td>
                        <td class="rang char_w">{{"{{spec.starting_xp}}"}}</td>
                    </tr>
                </table>
            </div>
            <div class="sw_back_s talentPanelOut fade_in" ng-show="curSpec != null">
                <button type="button" ng-click="mCont.CloseSpecies()" class="closeButton">X</button>
                <div class="talentPanel">
                    {{str2html rawImg}}
                    <h1>{{"{{curSpec.name}}"}}</h1>
                    <div class="characterBlock">
                        <div class="innerCharBlock">
                            <span><b>Br</b></span>
                            <span><b>Ag</b></span>
                            <span><b>In</b></span>
                            <span><b>Cu</b></span>
                            <span><b>Wi</b></span>
                            <span><b>Pr</b></span>
                        </div>
                        <div class="innerCharBlock">
                            <span>{{"{{curSpec.brawn}}"}}</span>
                            <span>{{"{{curSpec.agility}}"}}</span>
                            <span>{{"{{curSpec.intellect}}"}}</span>
                            <span>{{"{{curSpec.cunning}}"}}</span>
                            <span>{{"{{curSpec.willpower}}"}}</span>
                            <span>{{"{{curSpec.presence}}"}}</span>
                        </div>
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
