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
    <div class="left_page_col mid_col" ng-show="curCar.specializations != null">
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
    <div class="right_col">
        <div ng-show="curCar != null">
            <div class="characterBlock"><b>{{"{{curCar.name}}"}}</b></div>
            <p>Skill Proficiencies: {{"{{curCar.skill_slots}}"}}</p>
        </div>
        <div ng-show="curSpecial != null" class="specialWrap">
            <div class="characterBlock"><b>{{"{{curSpecial.name}}"}}</b></div>
            <p>Skill Proficiencies: {{"{{curSpecial.skill_slots}}"}}</p>
            <div class="talentBlock">
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[0].index)">{{"{{talents[curSpecial.talents[0].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[0].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[1].index)">{{"{{talents[curSpecial.talents[1].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[1].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[2].index)">{{"{{talents[curSpecial.talents[2].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[2].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[3].index)">{{"{{talents[curSpecial.talents[3].index].name}}"}}</span>
            </div>
            <div class="talentBlock">
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[0].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[1].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[2].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[3].disp_down" alt="Conn"/></span>
            </div>
            <div class="talentBlock">
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[4].index)">{{"{{talents[curSpecial.talents[4].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[4].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[5].index)">{{"{{talents[curSpecial.talents[5].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[5].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[6].index)">{{"{{talents[curSpecial.talents[6].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[6].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[7].index)">{{"{{talents[curSpecial.talents[7].index].name}}"}}</span>
            </div>
            <div class="talentBlock">
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[4].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[5].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[6].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[7].disp_down" alt="Conn"/></span>
            </div>
            <div class="talentBlock">
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[8].index)">{{"{{talents[curSpecial.talents[8].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[8].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[9].index)">{{"{{talents[curSpecial.talents[9].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[9].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[10].index)">{{"{{talents[curSpecial.talents[10].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[10].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[11].index)">{{"{{talents[curSpecial.talents[11].index].name}}"}}</span>
            </div>
            <div class="talentBlock">
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[8].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[9].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[10].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[11].disp_down" alt="Conn"/></span>
            </div>
            <div class="talentBlock">
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[12].index)">{{"{{talents[curSpecial.talents[12].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[12].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[13].index)">{{"{{talents[curSpecial.talents[13].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[13].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[14].index)">{{"{{talents[curSpecial.talents[14].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[14].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[15].index)">{{"{{talents[curSpecial.talents[15].index].name}}"}}</span>
            </div>
            <div class="talentBlock">
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[12].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[13].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[14].disp_down" alt="Conn"/></span>
                <span class="vConn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[15].disp_down" alt="Conn"/></span>
            </div>
            <div class="talentBlock">
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[16].index)">{{"{{talents[curSpecial.talents[16].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[16].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[17].index)">{{"{{talents[curSpecial.talents[17].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[17].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[18].index)">{{"{{talents[curSpecial.talents[18].index].name}}"}}</span>
                <span class="conn"><img src="/static/img/connector.png" ng-style="curSpecial.talents[18].disp_right" alt="Conn"/></span>
                <span class="talent sw_back" ng-click="mCont.RevealTalent(curSpecial.talents[19].index)">{{"{{talents[curSpecial.talents[19].index].name}}"}}</span>
            </div>
            <div class="talentPanel sw_back" ng-show="curTale != null" ng-style="mCont.talPanSty">
                <div class="characterBlock"><b>{{"{{curTale.name}}"}}</b></div>
                <p>{{"{{curTale.description}}"}}</p>
            </div>
        </div>
    </div>
</div>
