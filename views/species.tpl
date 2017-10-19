<div ng-show="mCont.ShowTab(1)" class="sixty_he fade_in">
    <div class="tablePage sw_back">
        <div class="tabPag_inner">
            <table>
                <tr class="bg_none">
                    <td colspan="4" class="table_name">Species</td>
                </tr>
                <tr>
                    <th>Name</th>
                    <th>Br</th>
                    <th>Ag</th>
                    <th>In</th>
                    <th>Cu</th>
                    <th>Wi</th>
                    <th>Pr</th>
                    <th>Wound Threshold</th>
                    <th>Strain Threshold</th>
                </tr>
                <tr ng-repeat="(ind, spec) in species" ng-click="mCont.RevealSpecies(ind)" class="item">
                    <td>{{"{{spec.name}}"}}</td>
                    <td class="numb">{{"{{spec.brawn}}"}}</td>
                    <td class="numb">{{"{{spec.agility}}"}}</td>
                    <td class="rang">{{"{{spec.intellect}}"}}</td>
                    <td class="rang">{{"{{spec.cunning}}"}}</td>
                    <td class="rang">{{"{{spec.willpower}}"}}</td>
                    <td class="rang">{{"{{spec.presence}}"}}</td>
                    <td class="rang">{{"{{spec.wound_threshold}}"}}</td>
                    <td class="rang">{{"{{spec.strain_threshold}}"}}</td>
                </tr>
            </table>
            <div class="sw_back talentPanelOut" ng-show="curSpec != null">
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
