<div ng-show="mCont.ShowTab(1)" class="sixty_he fade_in">
    <div class="left_page_col left_page">
        <div style="width: 100%">
            <h2>Species</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, spec) in species">
					    <span ng-click="mCont.RevealSpecies(ind)" class="clickable">
                            {{"{{spec.name}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page" ng-show="curSpec != null" id="specRight">
        {{str2html rawImg}}
        <h1>{{"{{curSpec.name}}"}}</h1>
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
                    <span>{{"{{attrib.description}}"}}</span>
                </li>
            </ul>
        </div>
    </div>
</div>
