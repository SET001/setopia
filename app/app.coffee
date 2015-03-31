window.app = angular.module('app', ['ngRoute'])
.service 'Config', ->
	enableAxis: yes
.config ['$routeProvider', ($routeProvider) ->
	console.log "configuring..."
	window.stime = (new Date()).getTime()

	# $routeProvider
	# 	.when '/system/:systemName', 
	# 		controller: 'PlanetSystemCtrl'
	# 		templateUrl: 'templates/planetSystem.html'
	# 	.when '/planet/:planetName', 
	# 		controller: 'PlanetCtrl'
	# 	.otherwise redirectTo: '/system/solar'
]
