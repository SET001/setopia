app.factory 'ForestTestView', ($rootScope, $q, $injector, View, Config, Settings, Forest, Floor, UserMan, SectorGrid)	->
	class ForestTestView extends View
		init: ->
			super()
			floor = new Floor
				width: 10000
				length: 10000
			floor.ready.then =>
				@collidables.push floor.mesh
				@scene.add floor.mesh
				@units.push floor
			@scene.add new SectorGrid Config.sector.width, 333
			# @scene.fog = new THREE.Fog 0x050505, 1000, 4000
			# @scene.fog.color.setHSL( 0.1, 0.5, 0.5 )
			# @renderer.setClearColor( @scene.fog.color )
