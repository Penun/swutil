{{template "includes/strain/header_w.tpl"}}
<body ng-controller="mainController as mCont" ng-cloak>
	<div class="mainDiv" id="forwardMain">
		<div class="page sw_back">
            <div class="sixty_he">
				<ul>
					<li ng-repeat="(ind, play) in players">
                		<p><label><b>{{"{{play.Name}}"}}</b></label></p>
                		<p><label><b>W:</b></label> {{"{{play.Wound}}"}}</p>
                		<p><label><b>S:</b></label> {{"{{play.Strain}}"}}</p>
					</li>
				</ul>
            </div>
		</div>
	</div>
</body>
</html>
