<div ng-show="mCont.ShowTab(1)" class="sixty_he fade_in">
    <div class="tablePage">
        <div class="tabPag_inner">
            <div class="headTable sw_back">
                <span class="th_head gridRow th_c_span"></span>
                <span class="th_table_name alCenter gridRow th_c_span">Species</span>
                <span class="th_head gridRow2 th_c_span"></span>
                <span class="gridCol gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'name', 'spNa')">Name</span>
                <span class="gridCol2 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'brawn', 'spBr')">Br</span>
                <span class="gridCol3 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'agility', 'spAg')">Ag</span>
                <span class="gridCol4 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'intellect', 'spIn')">In</span>
                <span class="gridCol5 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'cunning', 'spCu')">Cu</span>
                <span class="gridCol6 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'willpower', 'spWi')">Wi</span>
                <span class="gridCol7 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'presence', 'spPr')">Pr</span>
                <span class="gridCol8 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'wound_threshold', 'spWt')">Wound Threshold</span>
                <span class="gridCol9 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'strain_threshold', 'spSt')">Strain Threshold</span>
                <span class="gridCol10 gridRow2 th_table_name th_subTab_name alCenter sortable" ng-click="mCont.SortList(species, 'starting_xp', 'spSx')">Starting XP</span>
            </div>
            <div class="follTable">
                <div ng-repeat="(ind, spec) in species" ng-click="mCont.RevealSpecies(ind)" class="th_item">
                    <span>{{"{{spec.name}}"}}</span>
                    <span class="alCenter">{{"{{spec.brawn}}"}}</span>
                    <span class="alCenter">{{"{{spec.agility}}"}}</span>
                    <span class="alCenter">{{"{{spec.intellect}}"}}</span>
                    <span class="alCenter">{{"{{spec.cunning}}"}}</span>
                    <span class="alCenter">{{"{{spec.willpower}}"}}</span>
                    <span class="alCenter">{{"{{spec.presence}}"}}</span>
                    <span class="alCenter">{{"{{spec.wound_threshold}}"}}</span>
                    <span class="alCenter">{{"{{spec.strain_threshold}}"}}</span>
                    <span class="alCenter">{{"{{spec.starting_xp}}"}}</span>
                </div>
            </div>
            <div class="sw_back_s speciesPaOut fade_in" ng-show="curSpec != null">
                <div class="tp_spanCol tp_spanRow">{{str2html rawImg}}</div>
                <h1 class="tp_head">{{"{{curSpec.name}}"}}</h1><button type="button" ng-click="mCont.CloseSpecies()" class="closeButton">X</button>
                <div class="characterBlock gridRow2 tp_spanCol alCenter">
                    <span></span>
                    <span><b>Br</b></span>
                    <span><b>Ag</b></span>
                    <span><b>In</b></span>
                    <span><b>Cu</b></span>
                    <span><b>Wi</b></span>
                    <span><b>Pr</b></span>
                    <span></span>
                    <span></span>
                    <span>{{"{{curSpec.brawn}}"}}</span>
                    <span>{{"{{curSpec.agility}}"}}</span>
                    <span>{{"{{curSpec.intellect}}"}}</span>
                    <span>{{"{{curSpec.cunning}}"}}</span>
                    <span>{{"{{curSpec.willpower}}"}}</span>
                    <span>{{"{{curSpec.presence}}"}}</span>
                    <span></span>
                </div>
                <div class="gridCol gridRow3 tp_midRow">
                    <b>Wound Threshold:</b> {{"{{curSpec.wound_threshold}}"}} + Brawn
                </div>
                <div class="gridCol gridRow4 tp_midRow">
                    <b>Strain Threshold:</b> {{"{{curSpec.strain_threshold}}"}} + Willpower
                </div>
                <div class="gridCol gridRow5 tp_midRow">
                    <b>Starting XP:</b> {{"{{curSpec.starting_xp}}"}}
                </div>
                <div class="tp_spanCol gridRow6 alStretch">
                    <ul class="tp_specAbil">
                        <li ng-repeat="(ind, attrib) in curSpec.attributes">
                            <span ng-bind-html="attrib.description" class="taleDesc"></span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
