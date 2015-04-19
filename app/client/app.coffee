window.app = angular.module('app', ['ngRoute', 'ngCookies'])
.service 'Config', ->
	enableAxis: yes
	serverAddress: '127.0.0.1:8090'
.config ['$routeProvider', ($routeProvider) ->
	console.log "configuring..."
	window.stime = (new Date()).getTime()

	$routeProvider
		.when '/', 
			controller: 'MainCtrl'
			templateUrl: 'templates/main.html'
		.when '/settings', 
			controller: 'SettingsCtrl'
			templateUrl: 'templates/settings.html'
		.when '/wood', 
			controller: 'WoodTestCtrl'
			templateUrl: 'templates/main.html'
		.otherwise redirectTo: '/main'
]
