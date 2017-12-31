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
	                    <td>{{"{{play.player.name}}"}}</td>
	                    <td class="rang"><span ng-show="play.type != 'NPCE'">{{"{{play.cur_wound}}"}}/{{"{{play.player.wound}}"}}</span></td>
	                    <td class="rang"><span ng-show="play.type != 'NPCE' && play.player.strain > 0">{{"{{play.cur_strain}}"}}/{{"{{play.player.strain}}"}}</span></td>
	                    <td class="rang"><span ng-show="play.initiative > 0">{{"{{play.initiative}}"}}</span></td>
	                </tr>
	            </table>
            </div>
		</div>
	</div>
</body>
</html>
