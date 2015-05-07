app.factory 'ForestTestView', ['$rootScope','$q', '$injector', 'View', 'Config', 'Settings', 'Forest', 'Floor', 'UserMan'
, ($rootScope, $q, $injector, View, Config, Settings, Forest, Floor, UserMan)	->
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
			@initSectorGrid 100, 100
			# @scene.fog = new THREE.Fog 0x050505, 1000, 4000
			# @scene.fog.color.setHSL( 0.1, 0.5, 0.5 )
			# @renderer.setClearColor( @scene.fog.color )
		initSectorGrid: (sizex, sizey) ->
			width = Config.sector.width
			length = Config.sector.length
			material = new THREE.LineBasicMaterial color: 0xffffff
			x = -parseInt(sizex/2)*width
			y = 0.5
			z = -parseInt(sizey/2)*length
			for i in [0..sizex]
				g = new THREE.Geometry()
				g.vertices.push new THREE.Vector3 x+i*width, y, z
				g.vertices.push new THREE.Vector3 x+i*width, y, z+sizey*length
				line = new THREE.Line g, material
				@scene.add line
			for i in [0..sizey]
				g = new THREE.Geometry()
				g.vertices.push new THREE.Vector3 x, y, z+i*length
				g.vertices.push new THREE.Vector3 x+sizex*width, y, z+i*length
				line = new THREE.Line g, material
				@scene.add line
	
]