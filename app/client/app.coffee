window.app = angular.module('app', ['ngRoute', 'ngCookies'])
.service 'Config', ->
	enableAxis: yes
	serverAddress: '127.0.0.1:8090'
	sector:
		width: 100
		length: 100
.config ['$routeProvider', ($routeProvider) ->
	window.stime = (new Date()).getTime()

	$routeProvider
		.when '/', 
			controller: 'MainCtrl'
			templateUrl: 'templates/main.html'
		.when '/settings', 
			controller: 'SettingsCtrl'
			templateUrl: 'templates/settings.html'
		.when '/forest', 
			controller: 'ForestTestCtrl'
			templateUrl: 'templates/main.html'
		.otherwise redirectTo: '/main'
]
