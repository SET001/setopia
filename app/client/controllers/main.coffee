app.controller 'MainCtrl', ['$scope', 'Config', 'ControlsTestView', 'Controls', 'Settings', '$location', 'Server', ($scope, Config, View, Controls, Settings, $location, Server) ->
	unless Settings.get().username then $location.path '/settings'
	$scope.view = new View()

	$scope.config = Config
	$scope.controls = Controls
	$scope.server = Server
	$scope.connectError = no
	$scope.ready = no
	$scope.loading = no

	$scope.play = ->
		unless Server.isConnected
			$scope.loading = yes
			Server.connect(Settings.get().username).then (params) =>
				$scope.connectError = no
				unless $scope.view.initialised
					$scope.view.init()
					Controls.init $scope.view
					Controls.plc.getObject().add $scope.view.user.mesh
					$scope.view.animate()
				Controls.enable()
				console.log "successfully connected!", params
				if params? and params.world?
					$scope.view.loadWorld(params.world).then =>
						$scope.ready = yes
						window.stime -= (new Date()).getTime()
						console.log "Done in #{(window.stime*-1)/1000} seconds"
						$scope.loading = no
			, =>
				$scope.connectError = yes
				$scope.loading = no
		else 
			if Server.isConnected and $scope.view.initialised
				Controls.enable()
]