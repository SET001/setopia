app.service 'Server', ['$q', '$rootScope', 'Settings', 'Config', ($q, $rootScope, Settings, Config) ->
	isConnected: no
	users: []
	con: null
	connect: (username) ->
		console.log "connecting...", @
		connected = $q.defer()
		if true
			@con = io.connect Config.serverAddress
			@con.emit 'login', username

			@con.on 'connected', (params) =>
				@isConnected = yes
				console.log "connected"
				console.log @
				for user in params.users
					@users.push user
				connected.resolve params

			@con.on 'userLoggedIn', (username) =>
				console.log "user #{username} entered game"
				@users.push username
				$rootScope.$broadcast 'user entered', username
				$rootScope.$apply()

			@con.on 'userLoggedOut', (username) =>
				console.log "user #{username} quited game"
				@users = _.remove @users, username
				$rootScope.$broadcast 'user leave', username
				$rootScope.$apply()

			# @con.on 'position', (data) =>
			# 	# console.log "position", data
			# 	unless data.username is Settings.username
			# 		$rootScope.$broadcast 'user move', data

			@con.on 'unitAdd', (unit) =>
				$rootScope.$broadcast 'unitAdd', unit
				console.log "new unit", unit

			@con.on 'unitUpdate', (unit) =>
				$rootScope.$broadcast 'unitUpdate', unit

			@con.on 'unitRemove', (unit) =>
				$rootScope.$broadcast 'unitRemove', unit
		else
			connected.resolve()

		connected.promise
		# con.on 'userlist', (params) ->
		# 	console.log "got userlist", params
		# con.on 'username exists', (username) ->
		# 	console.log "such username alriedy exist"
	sendPosition: (position) ->
		if @isConnected
			@con.emit 'position',
				x: position.x
				y: position.y
				z: position.z
]