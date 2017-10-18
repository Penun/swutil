<div ng-show="mCont.ShowTab(4)" class="sixty_he fade_in">
    <div class="left_page_col">
        <div style="width: 100%">
            <h2>Armor</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, arm) in armor">
					    <span ng-click="mCont.RevealArmor(ind)" class="clickable">
                            {{"{{arm.type}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page" ng-show="curArmor != null" id="armRight">
        <div class="right_page_in">
            <h1>{{"{{curArmor.type}}"}}</h1>
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
