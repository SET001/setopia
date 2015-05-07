app.factory 'ForestSectorSpawner', (Sector, Forest) ->
	class BasicSectorSpawner
		spawn: (position) ->
			sector = new Sector position.x, position.y
			sector.units = Forest.spawn 1, sector.getArea()
			sector