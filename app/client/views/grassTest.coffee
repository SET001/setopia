app.factory 'GrassTestView', (View, Config, Settings, Floor)	->
	class GrassTestView extends View
		setLight: ->
			light	= new THREE.AmbientLight( 0x020202 )
			@scene.add( light )
			#add a light in front
			light	= new THREE.DirectionalLight('white', 1)
			light.position.set(0.5, 0.5, 2)
			@scene.add( light )
			#add a light behind
			light	= new THREE.DirectionalLight('white', 0.75)
			light.position.set(-0.5, -0.5, -2)
			@scene.add light
			#add a light behind
			light	= new THREE.DirectionalLight('white', 1)
			@scene.add light
			light.position.y= 1

		init: ->
			super()
			floor = new Floor
				width: Config.sector.width
				length: Config.sector.length
			floor.ready.then =>
				@collidables.push floor.mesh
				@scene.add floor.mesh
				@units.push floor


			THREEx.createGrassTufts.baseUrl	= ""
			nTufts	= 50000
			positions	= []
			console.log "generating positions"
			for i in [1..nTufts]
				position	= new THREE.Vector3()
				position.x	= (Math.random()-0.5)*Config.sector.width
				position.z	= (Math.random()-0.5)*Config.sector.length
				positions.push position
			console.log "done..."

			mesh	= THREEx.createGrassTufts positions
			console.log mesh

			@scene.add mesh


			# scene.add(mesh)
			# @scene.add new SectorGrid Config.sector.width, 333
			# @scene.fog = new THREE.Fog 0x050505, 1000, 4000
			# @scene.fog.color.setHSL( 0.1, 0.5, 0.5 )
			# @renderer.setClearColor( @scene.fog.color )
