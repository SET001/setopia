module.exports = class RatMan extends require './creature'
	target: null
	health: 5
	reverse: -1
	exports: ['position', 'health']
	behavior: ->
		if @searchTarget
			@position.x += 0.5*@reverse
			@position.z += 0.5*@reverse

		if @position.x < 0 || @position.x > 1000
			@reverse *= -1
		yes
	searchTarget: ->
		for unit in @world.units
			if unit.isPC then @target = unit
