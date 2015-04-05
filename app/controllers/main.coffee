app.controller 'MainCtrl', ['$scope', 'Config', 'View', 'Controls', 'Settings', '$location', 'Server', ($scope, Config, View, Controls, Settings, $location, Server) ->
	unless Settings.get().username then $location.path '/settings'

	$scope.config = Config
	$scope.controls = Controls
	$scope.server = Server

	$scope.ready = no
	$scope.users = ['asd']


	$scope.play = ->
		unless Server.isConnected
			View.init()
			Controls.enable()
			View.animate()
			Server.connect(Settings.get().username).then (params) =>
				console.log "successfully connected!", params
				View.loadWorld(params.world).then =>
					View.initUsers Server.users
					$scope.ready = yes
					window.stime -= (new Date()).getTime()
					console.log "Done in #{(window.stime*-1)/1000} seconds"
		else Controls.enable()
	# View.init().then =>
	# 	console.log "ready"
	# 	$scope.ready = yes
	# 	window.stime -= (new Date()).getTime()
	# 	console.log "Done in #{(window.stime*-1)/1000} seconds"
]