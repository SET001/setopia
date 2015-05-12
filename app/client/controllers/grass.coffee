app.controller 'GrassTestCtrl', ($scope, Config, GrassTestView, Controls, Player, CubeMan, SectorsManager, ForestSectorSpawner) ->

	$scope.view = new GrassTestView()
	$scope.config = Config
	$scope.view.init()

	$scope.player = new Player()
	$scope.player.setModel new CubeMan()
	
	
	Controls.init $scope.view
	Controls.plc.getObject().add $scope.player.model.mesh
	$scope.view.animate()

