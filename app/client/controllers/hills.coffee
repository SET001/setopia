app.controller 'HillsTestCtrl', ($scope, Config, HillsTestView, Controls, Player, CubeMan) ->

	console.log "hills"
	$scope.view = new HillsTestView()
	$scope.config = Config
	$scope.view.init()

	$scope.player = new Player()
	$scope.player.setModel new CubeMan()
	
	
	Controls.init $scope.view
	Controls.plc.getObject().add $scope.player.model.mesh
	$scope.view.animate()

