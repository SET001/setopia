app.controller 'ForestTestCtrl', ['$scope', 'Config', 'ForestTestView', 'Controls', ($scope, Config, View, Controls) ->
	$scope.view = new View()

	$scope.config = Config
	$scope.view.init()
	Controls.init $scope.view
	Controls.plc.getObject().add $scope.view.user.mesh
	$scope.view.animate()

	console.log "forest test"
]