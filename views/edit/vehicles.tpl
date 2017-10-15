<div ng-show="mCont.ShowTab(9)" class="sixty_he">
    <div class="left_page_col left_page">
        <div class="fade_in" style="width: 95%">
            <h2>Vehicles</h2>
            <div class="innerList">
                <ul>
				    <li ng-repeat="(ind, vehicle) in vehicles">
					    <span class="clickable">
                            {{"{{vehicle.model}}"}}
					    </span>
				    </li>
			    </ul>
            </div>
        </div>
    </div>
    <div class="right_page right_page_form">
        <form id="vehiAddForm" name="vehiAddForm" novalidate>
            <p><label><b>Model:</b></label><input type="text" name="vehiModel" id="vehiModel" ng-model="moldVehi.model" ng-change="mCont.CheckVehicle()" required/></p>
            <p><label><b>Type:</b></label><select name="vehiType" ng-model="moldVehi.type" class="sing_select" required>
                <option value="Airspeeder">Airspeeder</option>
                <option value="Cloud Car">Cloud Car</option>
                <option value="Speeder Bike">Speeder Bike</option>
                <option value="Swoop">Swoop</option>
                <option value="Speeder Truck">Speeder Truck</option>
                <option value="Landspeeder">Landspeeder</option>
                <option value="Mobile Refinery">Mobile Refinery</option>
                <option value="Groundcar">Groundcar</option>
                <option value="Walker">Walker</option>
            </select></p>
            <p><label><b>Silhouette:</b></label><input type="number" name="vehiSilh" ng-model="moldVehi.silhouette" placeholder="1" min="1" max="9" required/></p>
            <p><label><b>Speed:</b></label><input type="number" name="vehiSpeed" ng-model="moldVehi.speed" placeholder="1" min="1" max="9" required/></p>
            <p><label><b>Handling:</b></label><input type="number" name="vehiHand" ng-model="moldVehi.handling" placeholder="0" min="-9" max="9" required/></p>
            <p><label><b>Defense Forward:</b></label><input type="number" name="vehidefFor" ng-model="moldVehi.def_forward" placeholder="0" min="0" max="9" required/></p>
            <p><label><b>Defense Aft:</b></label><input type="number" name="vehidefAft" ng-model="moldVehi.def_aft" placeholder="0" min="0" max="9" required/></p>
            <p><label><b>Defense Port:</b></label><input type="number" name="vehidefPor" ng-model="moldVehi.def_port" min="0" max="9" /></p>
            <p><label><b>Defense Starboard:</b></label><input type="number" name="vehidefStr" ng-model="moldVehi.def_starboard" min="0" max="9" /></p>
            <p><label><b>Armor:</b></label><input type="number" name="vehiArmo" ng-model="moldVehi.armor" placeholder="1" min="0" max="9" required/></p>
            <p><label><b>HT Threshold:</b></label><input type="number" name="vehihtThresh" ng-model="moldVehi.ht_threshold" placeholder="1" min="1" max="99" required/></p>
            <p><label><b>SS Threshold:</b></label><input type="number" name="vehissThresh" ng-model="moldVehi.ss_threshold" placeholder="1" min="1" max="99" required/></p>
            <p><label><b>Manufacturer:</b></label><input type="text" name="vehiManif" ng-model="moldVehi.manufacturer" required/></p>
            <p><label><b>Maximum Altitude:</b></label><input type="number" name="vehiAlt" ng-model="moldVehi.max_altitude" min="0" step="10" required/></p>
            <p><label><b>Sensor Range:</b></label><select name="vehiSenso" ng-model="moldVehi.sensor_range" class="sing_select" required>
                <option value="None">None</option>
                <option value="Close">Close</option>
                <option value="Short">Short</option>
                <option value="Medium">Medium</option>
                <option value="Long">Long</option>
                <option value="Extreme">Extreme</option>
            </select></p>
            <p><label><b>Crew:</b></label><input type="text" name="vehiCrew" ng-model="moldVehi.crew" required/></p>
            <p><label><b>Encumbrance Capacity:</b></label><input type="text" name="vehiEncCap" ng-model="moldVehi.enc_capacity" required/></p>
            <p><label><b>Passenger Capacity:</b></label><input type="text" name="vehiPassCap" ng-model="moldVehi.pass_capacity" required/></p>
            <p><label><b>Cost:</b></label><input type="number" name="vehiCost" ng-model="moldVehi.cost" min="0" step="10" required/></p>
            <p><label><b>Rarity:</b></label><input type="number" name="vehiRari" ng-model="moldVehi.rarity" placeholder="1" min="1" max="9" required/></p>
            <p><label><b>Hard Points:</b></label><input type="number" name="vehiharPoi" ng-model="moldVehi.hard_points" placeholder="0" min="0" max="9" required/></p>
            <div class="abilities"><label><b>Weapons:</b></label><textarea name="vehiWeap" ng-model="moldVehi.weapons" rows="5" required></textarea></div>
            <div class="abilities"><label><b>Description:</b></label><textarea name="vehiDesc" ng-model="moldVehi.description" rows="5"></textarea></div>
            <button ng-show="vehiAddForm.$valid" ng-click="mCont.AddVehicle()" class="next_butt">Save</button>
        </form>
    </div>
</div>
