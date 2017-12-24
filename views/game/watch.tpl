{{template "includes/game/header_w.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
            <div class="sixty_he">
				<table>
	                <tr class="bg_none" ng-show="players.length == 0">
	                    <td colspan="4" class="table_name">Waiting../</td>
	                </tr>
	                <tr ng-show="players.length > 0">
	                    <th>Name</th>
	                    <th>Wound</th>
	                    <th>Strain</th>
	                    <th>Initiative</th>
	                </tr>
	                <tr ng-repeat="(ind, play) in players" ng-show="players.length > 0" ng-class="{activePlayer: startInit && play.isTurn, player: !play.isTurn || !startInit }">
	                    <td>{{"{{play.name}}"}}</td>
	                    <td class="rang"><span ng-show="play.wound > 0">{{"{{play.wound}}"}}</span></td>
	                    <td class="rang"><span ng-show="play.strain > 0">{{"{{play.strain}}"}}</span></td>
	                    <td class="rang"><span ng-show="play.initiative > 0">{{"{{play.initiative}}"}}</span></td>
	                </tr>
	            </table>
            </div>
		</div>
	</div>
</body>
</html>
