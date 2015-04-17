app.controller 'MainCtrl', ['$scope', 'Config', 'ControlsTestView', 'Controls', 'Settings', '$location', 'Server', '$interval', '$timeout', ($scope, Config, View, Controls, Settings, $location, Server, $interval, $timeout) ->
	unless Settings.get().username then $location.path '/settings'
	$scope.view = new View()

	$scope.config = Config
	$scope.controls = Controls
	$scope.server = Server
	$scope.connectError = no
	$scope.ready = no
	$scope.loading = no
	$scope.loadingMessage = ""

	$scope.play = ->
		unless Server.isConnected
			$scope.loading = yes
			$scope.loadingMessage = "Connecting"
			$interval ->
				$scope.loadingMessage += '.'
			, 1000
			Server.connect(Settings.get().username).then (params) =>
				console.log "successfully connected!", params
				$scope.connectError = no
				unless $scope.view.initialised
					$scope.loadingMessage += "View Init"
					$scope.view.init()
					Controls.init $scope.view
					Controls.plc.getObject().add $scope.view.user.mesh
					$scope.view.animate()
					console.log "view initialised!", params
				Controls.enable()
				if params? and params.world?
					$scope.loadingMessage = "Rendering world"
					$timeout =>
						$scope.view.loadWorld(params.world).then =>
							$scope.ready = yes
							window.stime -= (new Date()).getTime()
							console.log "Done in #{(window.stime*-1)/1000} seconds"
							$scope.loading = no
					, 1000
			, =>
				$scope.connectError = yes
				$scope.loading = no
		else 
			if Server.isConnected and $scope.view.initialised
				Controls.enable()
]