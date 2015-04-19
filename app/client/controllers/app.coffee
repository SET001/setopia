app.controller 'appCtrl', ['$scope', 'Settings', 'Controls', ($scope, Settings, Controls) ->
	$scope.controls = Controls
	$scope.play = ->
		Controls.enable()
]