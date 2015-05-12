app.factory 'ForestTestView', ($rootScope, $q, $injector, View, Config, Settings, Forest, Floor, UserMan, SectorGrid)	->
	class ForestTestView extends View
		init: ->
			super()
			floor = new Floor
				width: 1000000
				length: 1000000
			floor.ready.then =>
				@collidables.push floor.mesh
				@scene.add floor.mesh
				@units.push floor
			# @scene.add new SectorGrid Config.sector.width, 333
			# @scene.fog = new THREE.Fog 0x050505, 1000, 4000
			# @scene.fog.color.setHSL( 0.1, 0.5, 0.5 )
			# @renderer.setClearColor( @scene.fog.color )
			nTufts	= 50
			positions	= []
			for i in [1..nTufts]
				position	= new THREE.Vector3()
				position.x	= (Math.random()-0.5)*20
				position.z	= (Math.random()-0.5)*20
				positions.push position

			mesh	= THREEx.createGrassTufts positions
			console.log mesh
			textureUrl = THREEx.createGrassTufts.baseUrl+'/setopia/images/grass01.png'
			material = mesh.material
			material.map = THREE.ImageUtils.loadTexture textureUrl
			material.alphaTest = 0.7
			@scene.add mesh