module.exports = class UserMan extends require './creature'
	isPC: yes
	username: ''
	health: 10
	constructor:(username, settings)->
		super(settings)
		@username = username
