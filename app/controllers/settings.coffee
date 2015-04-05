app.controller 'SettingsCtrl', ['$scope', 'Settings', ($scope, Settings) ->
	$scope.settings = Settings.get()
	$scope.save = Settings.save
]