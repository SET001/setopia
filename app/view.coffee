app.service 'View', ['$rootScope','$q','Config','Controls','Fence','CubeMan','FenceCenter', 'Box', 'Designer'
, ($rootScope, $q, Config, Controls, Fence, CubeMan, FenceCenter, Box, Designer)	->
	View = 
		units: []
		collidables: []
		init: ($scope) ->
			@scene = new THREE.Scene()
			@renderer = new THREE.WebGLRenderer(antialias: true)
			@renderer.setSize window.innerWidth, window.innerHeight
			@renderer.shadowMapEnabled = yes
			document.body.appendChild @renderer.domElement
			window.addEventListener 'resize', =>
				width = window.innerWidth
				height = window.innerHeight
				@renderer.setSize width, height
				@camera.aspect = width / height
				@camera.updateProjectionMatrix()
			if Config.enableAxis
				axes = new THREE.AxisHelper 1000
				@scene.add axes
			@setCamera()
			@setSky()
			@setLight()
			@setFloor()
			@setStats()

			@user = new CubeMan
			@user.position.y = 20
			@user.position.z = 20
			@user.position.x = 20
			@user.mesh.rotation.y = 0.1
			@addUnit @user

			lineMaterial = new THREE.LineBasicMaterial color: 0x0000ff
			@userRays = []
			for vertex, i in @user.mesh.geometry.vertices
				lineGeometry = new THREE.Geometry()
				lineGeometry.vertices.push vertex, new THREE.Vector3()
				line = new THREE.Line lineGeometry, lineMaterial
				line.dynamic = true
				@userRays.push line
				@scene.add line

			map = [
				[0, 0, 100]
				[5, 0, 100]
				[10, 0, 100]
				[10, 5, 100]
				[15, 0, 100]
				[15, 5, 100]
				[15, 10, 100]
			]
			material = new THREE.MeshBasicMaterial color: 0x000000
			geometry = new THREE.BoxGeometry 5, 5, 5
			
			for item in map
				@addUnit new Box ->
					@mesh.position.x = item[0]
					@mesh.position.y = item[1]
					@mesh.position.z = item[2]

			designer = new Designer Box
			designer.ready.then =>
				step = 5
				for i in [0..10]
					designer
						.go 30, i*step, 150+i*step
						.line 20
						.go 30, 5, 155
						.line 20
					designer
						.go 130, 0, 150+i*step
						.lineUp 20
				for i in [0..15]
					designer
						.go 25, 0, 150+i*step
						.lineUp 20
				for i in [0..4]
					designer
						.go 30, 50, 150+55+i*step
						.line 40
				for i in [0..40]
					designer
						.go 30+i*step, 0, 150+55+20
						.lineUp 20

				console.log designer.units.length
				@addUnits designer.units
			# designer
			# 	.go 30, 5, 150
			# 	.line 20
			# console.log designer.cursor.matrix
			# designer.cursor.rotation.set 1.5, 0, 0
			# console.log designer.cursor.matrix
			# designer.line 10

				
			# material = new THREE.MeshBasicMaterial wireframe: true, color: 0x000000
			# geometry = new THREE.BoxGeometry 10, 100, 100
			# box = new THREE.Mesh geometry, material
			# box.position.set 100, 5, 100
			# @addUnit
			# 	name: "wall"
			# 	mesh: box
			# 	collidable: yes
			# 	ready: yes

			@controls = new Controls @user, @camera

			@addUnit new Fence ->
				@mesh.position.set 10, 0, 10
			@addUnit new FenceCenter ->
				@mesh.position.set 2, 1.5, 10
			@addUnit new FenceCenter ->
				@mesh.position.set -5.4, 1.5, 10
			@addUnit new Fence ->
				@mesh.position.set -13.5, 0, 10

			@addUnit new FenceCenter ->
				@mesh.position.set 30, 0, -50			
				@mesh.scale.set 10, 10, 10

			@addUnit new Fence ->
				@mesh.position.set 150, 0, -50			
				@mesh.scale.set 10, 10, 10

			window.stime -= (new Date()).getTime()
			console.log "Done in #{(window.stime*-1)/1000} seconds"

			# @drawRayLines()

			$rootScope.$on 'move', (e, direction) =>
				switch direction
					when 'forward' then directionVector = new THREE.Vector3 -100, 0, 0
					when 'backward' then directionVector = new THREE.Vector3 100, 0, 0
					when 'left' then directionVector = new THREE.Vector3 0, 0, -100
					when 'right' then directionVector = new THREE.Vector3 0, 0, 100
					when 'down' then directionVector = new THREE.Vector3 0, -100, 0
					when 'up' then directionVector = new THREE.Vector3 0, 100, 0
				if @isCanGo(@user.mesh, directionVector) then @user.move direction

			@animate()
		animate: (t) ->
			$rootScope.$broadcast 'move', 'down'
			View.controls.update()
			View.stats.update()
			View.render()
			window.requestAnimationFrame View.animate
		render: ->
			View.renderer.render View.scene, View.camera

		setCamera: ->
			@camera = new THREE.PerspectiveCamera 45, window.innerWidth / window.innerHeight, 0.1, 20000
			@camera.lookAt @scene.position
		setSky: ->
			skyBoxGeometry = new THREE.SphereGeometry 1280, 100, 100
			skyBoxTexture = new THREE.ImageUtils.loadTexture 'images/sky3.jpg'
			skyBoxTexture.wrapS = skyBoxTexture.wrapT = THREE.RepeatWrapping
			skyBoxTexture.repeat.set 8, 8
			skyBoxMaterial = new THREE.MeshBasicMaterial map: skyBoxTexture, side: THREE.DoubleSide
			skyBox = new THREE.Mesh skyBoxGeometry, skyBoxMaterial
			@scene.add skyBox
		setLight: ->
			light = new THREE.DirectionalLight 0xffffff, 1
			# light = new THREE.SpotLight 0xffffff
			light.castShadow = yes
			light.position.set(400,400,400)
			@scene.add light
			@scene.add new THREE.AmbientLight 0x555555
		setStats: ->
			@stats = new Stats()
			@stats.domElement.style.position = 'absolute'
			@stats.domElement.style.left = '0px'
			@stats.domElement.style.top = '0px'
			document.body.appendChild @stats.domElement
		setFloor: ->
			floorTexture = new THREE.ImageUtils.loadTexture 'images/grass4.png'
			floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping
			floorTexture.repeat.set 40, 40
			floorMaterial = new THREE.MeshLambertMaterial( { map: floorTexture, side: THREE.DoubleSide } )
			floorMaterial.receiveShadow = yes
			floorGeometry = new THREE.PlaneBufferGeometry 2560, 2560, 10, 10
			floor = new THREE.Mesh(floorGeometry, floorMaterial)
			floor.name = "Floor"
			floor.receiveShadow = yes
			floor.position.y = 0
			floor.rotation.x = Math.PI / 2
			@addUnit
				collidable: yes
				mesh: floor
				ready: yes

		addUnits: (units) ->
			for unit in units
				@addUnit unit
		addUnit: (unit) ->
			$q.when(unit.ready).then =>
				if unit.collidable
					@collidables.push unit.mesh
				@scene.add unit.mesh
		removeUnit: (unit) ->
			@collidables = _.reject @collidables, id: unit.id
			# if unit.collidable
			@scene.remove unit

		isCanGo: (object, direction) ->
			collisions = @countCollisions object, direction
			for name, distance of collisions
				if distance <1 then return no
			yes

		countCollisions: (object, direction) ->
			unless direction then direction = new THREE.Vector3 -100, 0, 0
			collisions = []
			originPoint = object.position.clone()
			# console.log "==="
			
			# ray = new THREE.Vector3 -1, 0, 0
			
			
			# localVertex = vertex.clone()
			# gVertex = localVertex.add originPoint
			# # console.log "gVertex", gVertex.x, vertex.x, originPoint.x
			# # gRay = gVertex.clone().sub ray
			# gRay = localVertex.applyMatrix4 object.matrix
			# gRay = gRay.sub object.position
			# # console.log "gray", gRay
			# # @userRays[i].geometry.vertices[1].set 100, 100, 100
			# # console.log "gray", gRay
			# # caster.set gVertex, gRay
			# caster = new THREE.Raycaster vertex, gRay.clone()
			# collisions = caster.intersectObjects @collidables
			# if collisions.length>0
			# 	for collision in collisions
			#  		console.log collision.distance, collision.object
			# @userRays[0].geometry.vertices[0] = vertex
			# @userRays[0].geometry.vertices[1] = gRay.clone()
			# @userRays[0].geometry.verticesNeedUpdate = yes


				# rayLine = 
				# gVertex = vertex.clone().add originPoint
				# caster.set gVertex, ray
				# collisions = caster.intersectObjects @collidables
				# console.log collisions
				# if collisions.length>0
				# 	console.log collisions[0].distance, collisions[0].object


			_collisions = {}
			for vertex,i in object.geometry.vertices
				localVertex = vertex.clone()

				globalVertex = vertex.clone().applyMatrix4 object.matrix
				directionPoint = vertex.clone().add(direction).applyMatrix4 object.matrix
				# directionVector = globalVertex.sub(object.position)
				directionVector = directionPoint.clone().sub(globalVertex).normalize()
				ray = new THREE.Raycaster( globalVertex, directionVector )
				collisions = ray.intersectObjects @collidables
				if collisions.length>0
					for collision in collisions
						# console.log collision.distance, collision.object
						if _collisions[collision.object.name]
							if _collisions[collision.object.name] > collision.distance
								_collisions[collision.object.name] = collision.distance
						else _collisions[collision.object.name] = collision.distance
				@userRays[i].geometry.vertices[0] = globalVertex
				@userRays[i].geometry.vertices[1] = directionPoint
				@userRays[i].geometry.verticesNeedUpdate = yes
			# console.log _collisions
			_collisions
]