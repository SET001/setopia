app.factory 'BasicSectorSpawner', (Sector) ->
	class BasicSectorSpawner
		spawn: (position) ->
			sector = new Sector position.x, position.y