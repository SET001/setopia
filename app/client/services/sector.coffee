app.factory 'Sector', (Config)->
	class Sector
#		Calculate sector coordinates in given point
#		@param		{THREE.Vector3} position - the point
#		@returns 	{THREE.Vector2} sector coordinates
		@at = (position) ->
			x = Math.round(position.x/Config.sector.width)
			y = Math.round(position.z/Config.sector.length)
			new  THREE.Vector2 x, y
		units: []
		constructor: (x=0, y=0) ->
			@units = []
			@x = x
			@y = y
		getArea: ->
			x1:	@x*Config.sector.width
			y1:	@y*Config.sector.length
			x2: (@x+1)*Config.sector.width
			y2: (@y+1)*Config.sector.length
		near: (direction) ->
			x: (@x + direction.x)+Math.pow(0, @x + direction.x)
			y: (@y + direction.y)+Math.pow(0, @y + direction.y)
