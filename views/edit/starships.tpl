<div ng-show="mCont.ShowTab(10)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Starships</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, starship) in starships">
					    <span class="clickable">
                            {{"{{starship.model}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page right_page_form">
        <form id="starAddForm" name="starAddForm" novalidate>
            <p><label><b>Model:</b></label><input type="text" name="starModel" id="starModel" ng-model="moldStar.model" ng-change="mCont.CheckStarship()" required/></p>
            <p><label><b>Type:</b></label><select name="starType" ng-model="moldStar.type" class="sing_select" required>
                <option value="Starfighter">Starfighter</option>
                <option value="Patrol Boat">Patrol Boat</option>
                <option value="Shuttle">Shuttle</option>
                <option value="Transport">Transport</option>
                <option value="Freighter">Freighter</option>
                <option value="Yacht">Yacht</option>
                <option value="Corvette">Corvette</option>
                <option value="Frigate">Frigate</option>
            </select></p>
            <p><label><b>Silhouette:</b></label><input type="number" name="starSilh" ng-model="moldStar.silhouette" placeholder="1" min="1" max="9" required/></p>
            <p><label><b>Speed:</b></label><input type="number" name="starSpeed" ng-model="moldStar.speed" placeholder="1" min="1" max="9" required/></p>
            <p><label><b>Handling:</b></label><input type="number" name="starHand" ng-model="moldStar.handling" placeholder="0" min="-9" max="9" required/></p>
            <p><label><b>Defense Forward:</b></label><input type="number" name="stardefFor" ng-model="moldStar.def_forward" placeholder="0" min="0" max="9" required/></p>
            <p><label><b>Defense Starboard:</b></label><input type="number" name="stardefStr" ng-model="moldStar.def_starboard" min="0" max="9" /></p>
            <p><label><b>Defense Port:</b></label><input type="number" name="stardefPor" ng-model="moldStar.def_port" min="0" max="9" /></p>
            <p><label><b>Defense Aft:</b></label><input type="number" name="stardefAft" ng-model="moldStar.def_aft" placeholder="0" min="0" max="9" required/></p>
            <p><label><b>Armor:</b></label><input type="number" name="starArmo" ng-model="moldStar.armor" placeholder="1" min="0" max="9" required/></p>
            <p><label><b>HT Threshold:</b></label><input type="number" name="starhtThresh" ng-model="moldStar.ht_threshold" placeholder="1" min="1" max="99" required/></p>
            <p><label><b>SS Threshold:</b></label><input type="number" name="starssThresh" ng-model="moldStar.ss_threshold" placeholder="1" min="1" max="99" required/></p>
            <p><label><b>Manufacturer:</b></label><input type="text" name="starManif" ng-model="moldStar.manufacturer" required/></p>
            <p><label><b>Hyperdrive:</b></label><input type="text" name="starHyp" ng-model="moldStar.hyperdrive" required/></p>
            <p><label><b>Navicomputer:</b></label><select name="starSenso" ng-model="moldStar.navicomputer" class="sing_select" required>
                <option value="None">None</option>
                <option value="Yes">Yes</option>
                <option value="Astromech Socket">Astromech Socket</option>
            </select></p>
            <p><label><b>Sensor Range:</b></label><select name="starSenso" ng-model="moldStar.sensor_range" class="sing_select" required>
                <option value="None">None</option>
                <option value="Close">Close</option>
                <option value="Short">Short</option>
                <option value="Medium">Medium</option>
                <option value="Long">Long</option>
                <option value="Extreme">Extreme</option>
            </select></p>
            <p><label><b>Complement:</b></label><input type="text" name="starCrew" ng-model="moldStar.complement" required/></p>
            <p><label><b>Encumbrance Capacity:</b></label><input type="text" name="starEncCap" ng-model="moldStar.enc_capacity" required/></p>
            <p><label><b>Passenger Capacity:</b></label><input type="text" name="starPassCap" ng-model="moldStar.pass_capacity" required/></p>
            <p><label><b>Consumables:</b></label><input type="text" name="starCons" ng-model="moldStar.consumables" required/></p>
            <p><label><b>Cost:</b></label><input type="number" name="starCost" ng-model="moldStar.cost" min="0" step="10" required/></p>
            <p><label><b>Rarity:</b></label><input type="number" name="starRari" ng-model="moldStar.rarity" placeholder="1" min="1" max="9" required/></p>
            <p><label><b>Hard Points:</b></label><input type="number" name="starharPoi" ng-model="moldStar.hard_points" placeholder="0" min="0" max="9" required/></p>
            <p><label><b>Book:</b></label><input type="text" name="starBook" ng-model="moldStar.book" maxlength="5" required/></p>
            <div class="abilities"><label><b>Weapons:</b></label><textarea name="starWeap" ng-model="moldStar.weapons" rows="5" required></textarea></div>
            <div class="abilities"><label><b>Customizations:</b></label><textarea name="starCust" ng-model="moldStar.customizations" rows="5"></textarea></div>
            <div class="abilities"><label><b>Description:</b></label><textarea name="starDesc" ng-model="moldStar.description" rows="5"></textarea></div>
            <button ng-show="starAddForm.$valid" ng-click="mCont.AddStarship()" class="next_butt">Save</button>
        </form>
    </div>
</div>
