_ = require 'lodash'
module.exports = class Unit
	position:
		x: 1
		y: 0
		z: 0
	world: null
	export: -> 
		if @exports? then _.pick @, @exports
		else
			keys = []
			_.forIn @, (v, k)->
				unless typeof v is 'function' || k in ['world']
					keys.push k
			_.pick @, keys
	constructor: (settings = null) ->
		if settings then _.assign @, settings
