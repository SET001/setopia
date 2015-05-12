window.app = angular.module('app', ['ngRoute', 'ngCookies'])
.service 'Config', ->
	enableAxis: yes
	serverAddress: '127.0.0.1:8090'
	sector:
		width: 1000
		length: 1000
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
		.when '/grass', 
			controller: 'GrassTestCtrl'
			templateUrl: 'templates/main.html'
		.otherwise redirectTo: '/main'
]
