app.factory 'SectorsManager', (Sector) ->
	class SectorsManager
		spawner: null
		constructor: (spawner) ->
			@spawner = spawner
		sectors: []
		all: ->
			@sectors

#	@param {THREE.Vector2} position
		get: (position) ->
			_.find @sectors,
				x: position.x
				y: position.y

#	calculate near sectors coordinates
#	@params {THREE.Vector2} position - around what position to calculate
#	@param {number} radius - distance from position
#	@return {Array.<THREE.Vector2>}
		calcNears: (position, radius=1) ->
			coords = []
			k = 3 + (radius-1)*2
			for x in [1..k]
				for y in [1..k]
					coords.push new THREE.Vector2 x-1-radius+position.x, y-1-radius+position.y
			coords

#	spawns near sectors if they does not exist
# @params {THREE.Vector2} position
# @params {number} radius
#	@returns {Array.<Sector>}	array of spawned sectors
		spawnNears: (position, radius) ->
			sectorCoords = @calcNears position, radius
			newSectors = []
			for coords in sectorCoords
				unless @get coords
					@sectors.push @spawner.spawn coords
					newSectors.push @spawner.spawn coords
			newSectors