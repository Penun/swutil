<div ng-show="mCont.ShowTab(1)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 85%">
            <h2>Species</h2>
            <div style="overflow: auto; height: 61vh;">
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
    <div class="right_page">
        <h2>{{"{{curSpec.name}}"}}</h2>
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
        <div class="threshold">
            <b>Wound Threshold:</b> {{"{{curSpec.wound_threshold}}"}} + Brawn
        </div>
        <div class="threshold">
            <b>Strain Threshold:</b> {{"{{curSpec.strain_threshold}}"}} + Willpower
        </div>
        <div class="threshold">
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
