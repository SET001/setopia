config = require './config'
fs = require 'fs'
World = require './world'
UserMan = require './units/userMan'

console.log "Starting..."
io = require('socket.io')(config.port)
console.log "done..."
_ = require 'lodash'

users = []
broadcast = (event, params) ->
	if users.length
		_.forEach users, (user) ->
			user.socket.emit event, params

world = new World()

world.load('default').then =>
	console.log "init"
	world.init()


world.onUnitAdded = (unit) ->
	broadcast 'unitAdd', unit.export()
world.onUnitUpdate = (unit, position) ->
	broadcast 'unitUpdate', unit.export()


io.on 'connection', (socket) ->
	console.log "user connected from ", socket.handshake.address
	user =
		socket: null
		username: ''
	socket.on 'error', (err) ->
		console.log "error:", err

	socket.on 'login', (username) ->
		console.log "login event", username
		if (_.find users, username: username)
			console.log "username exists"
			socket.emit 'username exists', username
		else
			console.log "user #{username} logged in ", socket.handshake.address
			data = 
				users: _.pluck users, 'username'
				world: world.export()
			socket.emit 'connected', data
				
			console.log "connected"
			broadcast 'userLoggedIn', username

			world.addUnit new UserMan username
			console.log "new user unit added"
			user.socket = socket
			console.log "socket added"
			user.username = username
			users.push user
			console.log "user pushed"

			
			socket.on 'disconnect', ->
				console.log "#{socket.handshake.address} disconnected"
				if user.socket
					broadcast 'userLoggedOut', user.username
					unit = _.find world.units, username: user.username
					broadcast 'unitRemove', unit.export()
					world.removeUnit id: unit.id
					users = _.reject users, username: user.username
			

			# 	# _.forEach users, (user) ->
			# 	# 	user.socket.emit 'userlist', userlist
			# 	# socket.emit 'userlist', 
			socket.on 'position', (position) ->
				if user
					unit = _.find world.units, username: user.username
					if unit
						unit.position = position
						broadcast 'unitUpdate', unit.export()
					else
						console.log "can`t find user to update it"
			# 		else
			# 			console.log "Can't find unit for user #{user.username}"

