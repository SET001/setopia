app.controller 'ForestTestCtrl', ($scope, Config, ForestTestView, Controls, Player, Sector, CubeMan, SectorsManager, ForestSectorSpawner) ->

	$scope.view = new ForestTestView()
	$scope.config = Config
	$scope.view.init()

	$scope.sectors = new SectorsManager new ForestSectorSpawner()

	$scope.player = new Player()
	$scope.player.setModel new CubeMan()
	sectorPos = Sector.at $scope.player.position
	console.log "current position >>", sectorPos, $scope.player.position
	sectors = $scope.sectors.spawnNears sectorPos
	for sector in sectors
		for unit in sector.units
		$scope.view.scene.add unit

	$scope.player.sector = $scope.sectors.get sectorPos
	console.log "===>", sectorPos, $scope.player.sector, $scope.sectors.all().length
	
	Controls.init $scope.view
	Controls.plc.getObject().add $scope.player.model.mesh
	$scope.view.animate()

	$scope.$on 'playerMove', (e, m)->
		sectorPos = Sector.at m
		if (sectorPos.x isnt $scope.player.sector.x or sectorPos.y isnt $scope.player.sector.y)
			console.log "Sector changed! Now in - #{sectorPos.x}:#{sectorPos.y}"
			nearsUnits = $scope.sectors.spawnNears sectorPos
			for unit in nearsUnits
				$scope.view.scene.add unit
			$scope.player.sector = $scope.sectors.get sectorPos

		$scope.$apply()
	console.log "forest test"