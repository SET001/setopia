app.controller 'MainCtrl', ['$scope', 'Config', 'ControlsTestView', 'Controls', 'Settings', '$location', 'Server', ($scope, Config, View, Controls, Settings, $location, Server) ->
	unless Settings.get().username then $location.path '/settings'
	$scope.view = new View()

	$scope.config = Config
	$scope.controls = Controls
	$scope.server = Server

	$scope.ready = no

	$scope.play = ->
		unless $scope.view.initialised
			$scope.view.init()
			Controls.init $scope.view
			Controls.plc.getObject().add $scope.view.user.mesh
			$scope.view.animate()
		unless Server.isConnected
			Server.connect(Settings.get().username).then (params) =>
				console.log "successfully connected!", params
				if params? and params.world?
					$scope.view.loadWorld(params.world).then =>
						$scope.ready = yes
						window.stime -= (new Date()).getTime()
						console.log "Done in #{(window.stime*-1)/1000} seconds"
		$scope.ready = yes
		Controls.enable()
		# unless Server.isConnected
		# 	Controls.enable()
		# 	View.animate()
		# 	Server.connect(Settings.get().username).then (params) =>
		# 		console.log "successfully connected!", params
		# 		if params? and params.world?
		# 			View.loadWorld(params.world).then =>
		# 				$scope.ready = yes
		# 				window.stime -= (new Date()).getTime()
		# 				console.log "Done in #{(window.stime*-1)/1000} seconds"
		# else Controls.enable()
	# View.init().then =>
	# 	console.log "ready"
	# 	$scope.ready = yes
	# 	window.stime -= (new Date()).getTime()
	# 	console.log "Done in #{(window.stime*-1)/1000} seconds"
]