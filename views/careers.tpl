<div ng-show="mCont.ShowTab(2)" class="sixty_he">
    <div class="tripPage">
        <div class="gridCol fade_in mobCol oThirdLCol colHigh" id="left_col">
            <h2 class="gridRow h2">Careers</h2>
            <div class="gridRow2 innerCol">
                <span ng-repeat="(ind, care) in careers" ng-click="mCont.RevealCareer(ind)" class="clickable alCenter">
                    {{"{{care.name}}"}}
	            </span>
            </div>
        </div>
        <div class="gridCol2 fade_in mobCol unexposed oThirdMCol colHigh" ng-show="curCar.specializations != null" id="mid_col">
            <div class="mobOnly"><h3>{{"{{curCar.name}}"}}</h3><button type="button" ng-click="mCont.BackToLeftCar()" class="closeButton">Back</button></div>
            <h2 class="gridRow h2">Specializations</h2>
            <div class="gridRow2 innerCol">
                <span ng-repeat="(ind, spec) in curCar.specializations" ng-click="mCont.RevealSpecialization(ind)" class="clickable alCenter">
                    {{"{{spec.name}}"}}
                </span>
            </div>
        </div>
        <div class="gridCol3 right_col mobCol unexposed fade_in" id="right_col" ng-show="curCar != null">
            <div class="mobOnly"><button type="button" ng-click="mCont.BackToMidCar()" class="closeButton">Back</button></div>
            <div>
                <h2 class="h2">{{"{{curCar.name}}"}}</h2>
                <p>Skill Proficiencies: {{"{{curCar.skill_slots}}"}}</p>
                <div class="skillDiv">
                    <span ng-repeat="(ind, skill) in curCar.skills" class="skill">
                        <i>{{"{{skills[skill].name}}"}}</i>
                    </span>
                </div>
            </div>
            <div class="fade_in" ng-show="curSpecial != null">
                <h2>{{"{{curSpecial.name}}"}}</h2>
                <p>Skill Proficiencies: {{"{{curSpecial.skill_slots}}"}}</p>
                <div class="skillDiv">
                    <span ng-repeat="(ind, skill) in curSpecial.skills" class="skill">
                        <i>{{"{{skills[skill].name}}"}}</i>
                    </span>
                </div>
                <h2 class="h2">Talent Tree</h2>
                <div class="specialWrap">
                    <div class="talent sw_back gridCol gridRow" ng-click="mCont.RevealTalent(curSpecial.talents[0].index)">{{"{{talents[curSpecial.talents[0].index].name}}"}}</div>
                    <div class="conn gridCol2 gridRow"><img src="/static/img/connector.png" ng-style="curSpecial.talents[0].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol3 gridRow" ng-click="mCont.RevealTalent(curSpecial.talents[1].index)">{{"{{talents[curSpecial.talents[1].index].name}}"}}</div>
                    <div class="conn gridCol4 gridRow"><img src="/static/img/connector.png" ng-style="curSpecial.talents[1].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol5 gridRow" ng-click="mCont.RevealTalent(curSpecial.talents[2].index)">{{"{{talents[curSpecial.talents[2].index].name}}"}}</div>
                    <div class="conn gridCol6 gridRow"><img src="/static/img/connector.png" ng-style="curSpecial.talents[2].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol7 gridRow" ng-click="mCont.RevealTalent(curSpecial.talents[3].index)">{{"{{talents[curSpecial.talents[3].index].name}}"}}</div>
                    <div class="vConn gridCol gridRow2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[0].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol3 gridRow2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[1].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol5 gridRow2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[2].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol7 gridRow2"><img src="/static/img/connector.png" ng-style="curSpecial.talents[3].disp_down" alt="Conn"/></div>
                    <div class="talent sw_back gridCol gridRow3" ng-click="mCont.RevealTalent(curSpecial.talents[4].index)">{{"{{talents[curSpecial.talents[4].index].name}}"}}</div>
                    <div class="conn gridCol2 gridRow3"><img src="/static/img/connector.png" ng-style="curSpecial.talents[4].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol3 gridRow3" ng-click="mCont.RevealTalent(curSpecial.talents[5].index)">{{"{{talents[curSpecial.talents[5].index].name}}"}}</div>
                    <div class="conn gridCol4 gridRow3"><img src="/static/img/connector.png" ng-style="curSpecial.talents[5].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol5 gridRow3" ng-click="mCont.RevealTalent(curSpecial.talents[6].index)">{{"{{talents[curSpecial.talents[6].index].name}}"}}</div>
                    <div class="conn gridCol6 gridRow3"><img src="/static/img/connector.png" ng-style="curSpecial.talents[6].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol7 gridRow3" ng-click="mCont.RevealTalent(curSpecial.talents[7].index)">{{"{{talents[curSpecial.talents[7].index].name}}"}}</div>
                    <div class="vConn gridCol gridRow4"><img src="/static/img/connector.png" ng-style="curSpecial.talents[4].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol3 gridRow4"><img src="/static/img/connector.png" ng-style="curSpecial.talents[5].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol5 gridRow4"><img src="/static/img/connector.png" ng-style="curSpecial.talents[6].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol7 gridRow4"><img src="/static/img/connector.png" ng-style="curSpecial.talents[7].disp_down" alt="Conn"/></div>
                    <div class="talent sw_back gridCol gridRow5" ng-click="mCont.RevealTalent(curSpecial.talents[8].index)">{{"{{talents[curSpecial.talents[8].index].name}}"}}</div>
                    <div class="conn gridCol2 gridRow5"><img src="/static/img/connector.png" ng-style="curSpecial.talents[8].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol3 gridRow5" ng-click="mCont.RevealTalent(curSpecial.talents[9].index)">{{"{{talents[curSpecial.talents[9].index].name}}"}}</div>
                    <div class="conn gridCol4 gridRow5"><img src="/static/img/connector.png" ng-style="curSpecial.talents[9].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol5 gridRow5" ng-click="mCont.RevealTalent(curSpecial.talents[10].index)">{{"{{talents[curSpecial.talents[10].index].name}}"}}</div>
                    <div class="conn gridCol6 gridRow5"><img src="/static/img/connector.png" ng-style="curSpecial.talents[10].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol7 gridRow5" ng-click="mCont.RevealTalent(curSpecial.talents[11].index)">{{"{{talents[curSpecial.talents[11].index].name}}"}}</div>
                    <div class="vConn gridCol gridRow6"><img src="/static/img/connector.png" ng-style="curSpecial.talents[8].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol3 gridRow6"><img src="/static/img/connector.png" ng-style="curSpecial.talents[9].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol5 gridRow6"><img src="/static/img/connector.png" ng-style="curSpecial.talents[10].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol7 gridRow6"><img src="/static/img/connector.png" ng-style="curSpecial.talents[11].disp_down" alt="Conn"/></div>
                    <div class="talent sw_back gridCol gridRow7" ng-click="mCont.RevealTalent(curSpecial.talents[12].index)">{{"{{talents[curSpecial.talents[12].index].name}}"}}</div>
                    <div class="conn gridCol2 gridRow7"><img src="/static/img/connector.png" ng-style="curSpecial.talents[12].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol3 gridRow7" ng-click="mCont.RevealTalent(curSpecial.talents[13].index)">{{"{{talents[curSpecial.talents[13].index].name}}"}}</div>
                    <div class="conn gridCol4 gridRow7"><img src="/static/img/connector.png" ng-style="curSpecial.talents[13].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol5 gridRow7" ng-click="mCont.RevealTalent(curSpecial.talents[14].index)">{{"{{talents[curSpecial.talents[14].index].name}}"}}</div>
                    <div class="conn gridCol6 gridRow7"><img src="/static/img/connector.png" ng-style="curSpecial.talents[14].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol7 gridRow7" ng-click="mCont.RevealTalent(curSpecial.talents[15].index)">{{"{{talents[curSpecial.talents[15].index].name}}"}}</div>
                    <div class="vConn gridCol gridRow8"><img src="/static/img/connector.png" ng-style="curSpecial.talents[12].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol3 gridRow8"><img src="/static/img/connector.png" ng-style="curSpecial.talents[13].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol5 gridRow8"><img src="/static/img/connector.png" ng-style="curSpecial.talents[14].disp_down" alt="Conn"/></div>
                    <div class="vConn gridCol7 gridRow8"><img src="/static/img/connector.png" ng-style="curSpecial.talents[15].disp_down" alt="Conn"/></div>
                    <div class="talent sw_back gridCol gridRow9" ng-click="mCont.RevealTalent(curSpecial.talents[16].index)">{{"{{talents[curSpecial.talents[16].index].name}}"}}</div>
                    <div class="conn gridCol2 gridRow9"><img src="/static/img/connector.png" ng-style="curSpecial.talents[16].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol3 gridRow9" ng-click="mCont.RevealTalent(curSpecial.talents[17].index)">{{"{{talents[curSpecial.talents[17].index].name}}"}}</div>
                    <div class="conn gridCol4 gridRow9"><img src="/static/img/connector.png" ng-style="curSpecial.talents[17].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol5 gridRow9" ng-click="mCont.RevealTalent(curSpecial.talents[18].index)">{{"{{talents[curSpecial.talents[18].index].name}}"}}</div>
                    <div class="conn gridCol6 gridRow9"><img src="/static/img/connector.png" ng-style="curSpecial.talents[18].disp_right" alt="Conn"/></div>
                    <div class="talent sw_back gridCol7 gridRow9" ng-click="mCont.RevealTalent(curSpecial.talents[19].index)">{{"{{talents[curSpecial.talents[19].index].name}}"}}</div>
                    <div class="sw_back_s talentPaOut fade_in" ng-show="curTale != null">
                        <div class="talentPanel">
                            <button type="button" ng-click="mCont.CloseTalent()" class="closeButton">X</button>
                            <div class="gridRow gridCol h2">{{"{{curTale.name}}"}}</div>
                            <div class="gridRow2 gridCol">Type: {{"{{curTale.type}}"}}</div>
                            <div class="gridRow3 gridCol">Ranked:
                                <span style="float: none;" ng-if="curTale.ranked">Yes</span>
                                <span style="float: none;" ng-if="!curTale.ranked">No</span>
                            </div>
                            <div ng-bind-html="curTale.description" class="taleDesc gridRow4 tp_spanCol"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
