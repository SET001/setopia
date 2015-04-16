fs = require 'fs'
_ = require 'lodash'
RatMan = require './units/ratMan'
TradeMan = require './units/tradeMan'
Q = require 'q'
Tree = require './units/Tree'
Floor = require './units/Floor'

module.exports = class World
	name: ''
	unitsId: 0
	width: 1000
	length: 1000
	units: []
	behaviors: []
	constructor: ->
		@units = []
		@behaviors = []
	export: ->
		_.map @units, (unit) -> 
			unit.export()

	addUnit: (unit) ->
		unit.id = @unitsId++
		unit.className = unit.constructor.name
		unit.world = @
		@units.push unit
		@onUnitAdded unit
		unit
	removeUnit: (unit) ->
		console.log "removing unit", unit
		@units = _.reject @units, unit
	onUnitAdded: ->
	load: (worldName)	->
		defer = Q.defer()
		worldFile = "worlds/#{worldName}.json"
		console.log "Loading world #{worldFile}..."
		fs.readFile worldFile, "utf8", (err, data) =>
			if err
				throw new Error "Failed to open world file #{worldFile}!"
				defer.reject()
			else
				@name = worldName
				for unit in JSON.parse data
					unit = new (require "./units/#{unit.className}")(unit)
					@addUnit unit
				console.log "world loaded!"
				defer.resolve()
		defer.promise
	save: (worldName, world) ->
		sw = JSON.stringify @export()
		console.log sw
		fs.writeFile "worlds/#{worldName}.json", sw

	init: ->
		# @addUnit new Floor()
		# console.log "world init"
		# for i in [1..200]
		# 	loop
		# 		x = Math.random()*@length*2 - @length/2
		# 		if x >600 or x < 400 then break

		# 	tree = new Tree
		# 		position:
		# 			x: x
		# 			y: 3
		# 			z: Math.random()*@width*2 - @length/2

		# 	@addUnit tree

		# console.log "trees spawned"
		# @save 'default'
		# @addUnit new TradeMan
		# 	position:
		# 		x: 100
		# 		y: 3
		# 		z: 100
		# @addUnit new TradeMan
		# 	position:
		# 		x: 500
		# 		y: 3
		# 		z: -200

		# rat = new Rat()
		# rat.position =
		# 	x: Math.random()*@length
		# 	y: 2
		# 	z: Math.random()*@width
		# rat.className = "RatMan"
		# rat.params =
		# 	id: @units.length
		# @units.push rat
		# @
			# className: 'RatMan'
			# position: rat.position
			# params:
			# 	id: 12213
		# @behaviors.push rat


		# setInterval =>
		# 	for unit in @behaviors
		# 		if unit.behavior()
		# 			@onUnitUpdate unit
		# , 10
		# # rats spawner
		# cr = 0
		# setInterval =>
		# 	if cr < 2
		# 		@addUnit new RatMan
		# 			position:
		# 				x: Math.random()*@length
		# 				y: 2
		# 				z: Math.random()*@width
		# 		cr++
		# , 1
