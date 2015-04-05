window.app = angular.module('app', ['ngRoute', 'ngCookies'])
.service 'Config', ->
	enableAxis: yes
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
		.otherwise redirectTo: '/main'
]
