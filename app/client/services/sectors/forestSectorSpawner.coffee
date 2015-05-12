app.factory 'ForestSectorSpawner', (Sector, Forest) ->
	class BasicSectorSpawner
		spawn: (position) ->
			sector = new Sector position.x, position.y
			sector.units.push Forest.spawn 100, sector.getArea()
			sector