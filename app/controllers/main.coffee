app.controller 'MainCtrl', ['$scope', 'Config', 'View', ($scope, Config, View) ->
	console.log "root controller"
	$scope.config = Config
	View.init $scope
]