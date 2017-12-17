<div ng-show="mCont.ShowTab(2)" class="sixty_he fade_in">
    <div class="left_page_col">
        <div style="width: 100%">
            <h2>Careers</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, care) in careers">
					    <span ng-click="mCont.RevealCareer(ind)" class="clickable">
                            {{"{{care.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="left_page_col mid_col fade_in" ng-show="curCar.specializations != null" id="carSpecCol">
        <div style="width: 100%">
            <h2>Specializations</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, spec) in curCar.specializations">
					    <span ng-click="mCont.RevealSpecialization(ind)" class="clickable">
                            {{"{{spec.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_col" id="right_col">
        <div class="fade_in" ng-show="curCar != null">
            <div class="characterBlock"><b>{{"{{curCar.name}}"}}</b></div>
            <p>Skill Proficiencies: {{"{{curCar.skill_slots}}"}}</p>
            <span class="skillSpan"><ul>
                <li ng-repeat="(ind, skill) in curCar.skills" class="skill">
                    <span><i>{{"{{skills[skill].name}}"}}</i></span>
                </li>
            </ul></span>
        </div>
        <div class="fade_in specializ" ng-show="curSpecial != null">
            <div class="characterBlock"><b>{{"{{curSpecial.name}}"}}</b></div>
            <p>Skill Proficiencies: {{"{{curSpecial.skill_slots}}"}}</p>
            <span class="skillSpan"><ul>
                <li ng-repeat="(ind, skill) in curSpecial.skills" class="skill">
                    <span><i>{{"{{skills[skill].name}}"}}</i></span>
                </li>
            </ul></span>
            <div class="specialWrap">
                <div class="talentBlock talRow1">
                    <div class="talent sw_back talCol1" ng-click="mCont.RevealTalent(curSpecial.talents[0].index)">{{"{{talents[curSpecial.talents[0].index].name}}"}}</div>
                    <div class="conn connCol1"><img src="/static/img/connector.png" ng-style="curSpecial.talents[0].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol2" ng-click="mCont.RevealTalent(curSpecial.talents[1].index)">{{"{{talents[curSpecial.talents[1].index].name}}"}}</div>
                    <div class="conn connCol2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[1].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol3" ng-click="mCont.RevealTalent(curSpecial.talents[2].index)">{{"{{talents[curSpecial.talents[2].index].name}}"}}</div>
                    <div class="conn connCol3"><img src="/static/img/connector.png" ng-style="curSpecial.talents[2].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol4" ng-click="mCont.RevealTalent(curSpecial.talents[3].index)">{{"{{talents[curSpecial.talents[3].index].name}}"}}</div>
                </div>
                <div class="talentBlock vConnRow1">
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[0].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[1].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[2].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[3].disp_down" alt="Conn"/></div>
                </div>
                <div class="talentBlock talRow2">
                    <div class="talent sw_back talCol1" ng-click="mCont.RevealTalent(curSpecial.talents[4].index)">{{"{{talents[curSpecial.talents[4].index].name}}"}}</div>
                    <div class="conn connCol1"><img src="/static/img/connector.png" ng-style="curSpecial.talents[4].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol2" ng-click="mCont.RevealTalent(curSpecial.talents[5].index)">{{"{{talents[curSpecial.talents[5].index].name}}"}}</div>
                    <div class="conn connCol2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[5].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol3" ng-click="mCont.RevealTalent(curSpecial.talents[6].index)">{{"{{talents[curSpecial.talents[6].index].name}}"}}</div>
                    <div class="conn connCol3"><img src="/static/img/connector.png" ng-style="curSpecial.talents[6].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol4" ng-click="mCont.RevealTalent(curSpecial.talents[7].index)">{{"{{talents[curSpecial.talents[7].index].name}}"}}</div>
                </div>
                <div class="talentBlock vConnRow2">
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[4].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[5].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[6].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[7].disp_down" alt="Conn"/></div>
                </div>
                <div class="talentBlock talRow3">
                    <div class="talent sw_back talCol1" ng-click="mCont.RevealTalent(curSpecial.talents[8].index)">{{"{{talents[curSpecial.talents[8].index].name}}"}}</div>
                    <div class="conn connCol1"><img src="/static/img/connector.png" ng-style="curSpecial.talents[8].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol2" ng-click="mCont.RevealTalent(curSpecial.talents[9].index)">{{"{{talents[curSpecial.talents[9].index].name}}"}}</div>
                    <div class="conn connCol2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[9].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol3" ng-click="mCont.RevealTalent(curSpecial.talents[10].index)">{{"{{talents[curSpecial.talents[10].index].name}}"}}</div>
                    <div class="conn connCol3"><img src="/static/img/connector.png" ng-style="curSpecial.talents[10].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol4" ng-click="mCont.RevealTalent(curSpecial.talents[11].index)">{{"{{talents[curSpecial.talents[11].index].name}}"}}</div>
                </div>
                <div class="talentBlock vConnRow3">
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[8].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[9].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[10].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[11].disp_down" alt="Conn"/></div>
                </div>
                <div class="talentBlock talRow4">
                    <div class="talent sw_back talCol1" ng-click="mCont.RevealTalent(curSpecial.talents[12].index)">{{"{{talents[curSpecial.talents[12].index].name}}"}}</div>
                    <div class="conn connCol1"><img src="/static/img/connector.png" ng-style="curSpecial.talents[12].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol2" ng-click="mCont.RevealTalent(curSpecial.talents[13].index)">{{"{{talents[curSpecial.talents[13].index].name}}"}}</div>
                    <div class="conn connCol2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[13].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol3" ng-click="mCont.RevealTalent(curSpecial.talents[14].index)">{{"{{talents[curSpecial.talents[14].index].name}}"}}</div>
                    <div class="conn connCol3"><img src="/static/img/connector.png" ng-style="curSpecial.talents[14].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol4" ng-click="mCont.RevealTalent(curSpecial.talents[15].index)">{{"{{talents[curSpecial.talents[15].index].name}}"}}</div>
                </div>
                <div class="talentBlock vConnRow4">
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[12].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[13].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[14].disp_down" alt="Conn"/></div>
                    <div class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[15].disp_down" alt="Conn"/></div>
                </div>
                <div class="talentBlock talRow5">
                    <div class="talent sw_back talCol1" ng-click="mCont.RevealTalent(curSpecial.talents[16].index)">{{"{{talents[curSpecial.talents[16].index].name}}"}}</div>
                    <div class="conn connCol1"><img src="/static/img/connector.png" ng-style="curSpecial.talents[16].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol2" ng-click="mCont.RevealTalent(curSpecial.talents[17].index)">{{"{{talents[curSpecial.talents[17].index].name}}"}}</div>
                    <div class="conn connCol2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[17].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol3" ng-click="mCont.RevealTalent(curSpecial.talents[18].index)">{{"{{talents[curSpecial.talents[18].index].name}}"}}</div>
                    <div class="conn connCol3"><img src="/static/img/connector.png" ng-style="curSpecial.talents[18].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back talCol4" ng-click="mCont.RevealTalent(curSpecial.talents[19].index)">{{"{{talents[curSpecial.talents[19].index].name}}"}}</div>
                </div>
                <div class="sw_back_s talentPanelOut fade_in" ng-show="curTale != null">
                    <button type="button" ng-click="mCont.CloseTalent()" class="closeButton">X</button>
                    <div class="talentPanel">
                        <div class="characterBlock"><b>{{"{{curTale.name}}"}}</b></div>
                        <div class="characterBlock">Type: {{"{{curTale.type}}"}}</div>
                        <div class="characterBlock">Ranked:
                            <span style="float: none;" ng-if="curTale.ranked">Yes</span>
                            <span style="float: none;" ng-if="!curTale.ranked">No</span>
                        </div>
                        <div ng-bind-html="curTale.description" class="taleDesc"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
