app.factory 'View', ['$rootScope','$q', '$injector', 'Config', 'Settings', 'Controls', 'Server'
, ($rootScope, $q, $injector, Config, Settings, Controls, Server)	->
	class View
		units: []
		collidables: []
		initialised: no
		loadWorld: (world) ->
			defer = $q.defer()
			for unitInto in world
				if !(unitInto.isPC and unitInto.username is Settings.username)
					factory = $injector.get unitInto.className
					unit = new factory unitInto
					if unitInto.position
						unit.mesh.position.x = unitInto.position.x
						unit.mesh.position.y = unitInto.position.y
						unit.mesh.position.z = unitInto.position.z
					if unit.collidable
							@collidables.push unit.mesh
					@scene.add unit.mesh
					@units.push unit
			console.log "world loaded", @units
			defer.resolve()
			defer.promise
		init: ->

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
			@setStats()

			$rootScope.$on 'unitRemove', (e, unitInfo) =>
				console.log "removing unit", unitInfo, @units
				unit = _.find @units, id: unitInfo.id
				if unit
					if unit.isPC
						console.log "#{unit.username} exited"
					_.without @units, id: unit.id
					@scene.remove unit.mesh
				else
					console.log "can't find unit"
				$rootScope.$apply()

			$rootScope.$on 'unitAdd', (e, unitInfo) =>
				console.log "new unit", unitInfo
				factory = $injector.get unitInfo.className
				unit = new factory unitInfo
				if unitInfo.position
					unit.mesh.position.x = unitInfo.position.x
					unit.mesh.position.y = unitInfo.position.y
					unit.mesh.position.z = unitInfo.position.z
				if unit.collidable
			 		@collidables.push unit.mesh
				@units.push unit
				@scene.add unit.mesh
				console.log "new unit added", unit
			$rootScope.$on 'unitUpdate', (e, unitInfo) =>
				unit = _.find @units, id: unitInfo.id
				if unit
					unit.position.x = unitInfo.position.x
					unit.position.y = unitInfo.position.y
					unit.position.z = unitInfo.position.z

					# console.log "found"
				# else
				# 	console.log "not found"

			# $rootScope.$on 'user leave', (e, username) =>
			# 	console.log "#{username} exited"
			# 	user = _.find @users, name: username
			# 	if user
			# 		console.log "removing user #{username}"
			# 		@users = _.reject @users, name: username
			# 		@scene.remove user.mesh
			# 	console.log @users
			# 	$rootScope.$apply()


			# $rootScope.$on 'user entered', (e, username) =>
			# 	console.log "#{username} entered"
			# 	user = new CubeMan
			# 	user.name = username
			# 	@users.push user
			# 	@scene.add user.mesh
			# 	console.log @users
			# 	$rootScope.$apply()
			# $rootScope.$on 'user move', (e, data) =>
			# 	user = _.find @users, name: data.username
			# 	if user
			# 		user.mesh.position.x = data.position.x
			# 		user.mesh.position.y = data.position.y
			# 		user.mesh.position.z = data.position.z


			# $rootScope.$on 'move', (e, direction) =>
			# 	switch direction
			# 		when 'forward' then directionVector = new THREE.Vector3 -100, 0, 0
			# 		when 'backward' then directionVector = new THREE.Vector3 100, 0, 0
			# 		when 'left' then directionVector = new THREE.Vector3 0, 0, -100
			# 		when 'right' then directionVector = new THREE.Vector3 0, 0, 100
			# 		when 'down' then directionVector = new THREE.Vector3 0, -100, 0
			# 		when 'up' then directionVector = new THREE.Vector3 0, 100, 0
			# 	if @isCanGo(@user.mesh, directionVector)
			# 		@user.move direction
			# 		Server.sendPosition @user.mesh.position

			# World.init().then (units) =>
			# 	console.log units.length
			# 	for unit in units
			# 		if unit.collidable
			# 			@collidables.push unit.mesh
			# 		console.log unit
			# 		@scene.add unit.mesh

			# 	@animate()
			# 	defer.resolve()
			# 	@ready = yes
					
			# lineMaterial = new THREE.LineBasicMaterial color: 0x0000ff
			# @userRays = []
			# for vertex, i in @user.mesh.geometry.vertices
			# 	lineGeometry = new THREE.Geometry()
			# 	lineGeometry.vertices.push vertex, new THREE.Vector3()
			# 	line = new THREE.Line lineGeometry, lineMaterial
			# 	line.dynamic = true
			# 	@userRays.push line
			# 	@scene.add line


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

			# @drawRayLines()
			@initialised = yes
		animate: (t) ->
			$rootScope.$broadcast 'move', 'down'
			Controls.update()
			@stats.update()
			@render()
			window.requestAnimationFrame @animate.bind @
		render: ->
			@renderer.render @scene, @camera

		setCamera: ->
			@camera = new THREE.PerspectiveCamera 45, window.innerWidth / window.innerHeight, 0.1, 20000
			@camera.lookAt @scene.position

		setSky: ->
			skyBoxGeometry = new THREE.SphereGeometry 16280, 100, 100
			skyBoxTexture = new THREE.ImageUtils.loadTexture 'images/redday.jpg'
			skyBoxTexture.wrapS = skyBoxTexture.wrapT = THREE.RepeatWrapping
			skyBoxTexture.repeat.set 1, 1
			skyBoxMaterial = new THREE.MeshBasicMaterial map: skyBoxTexture, side: THREE.DoubleSide
			skyBox = new THREE.Mesh skyBoxGeometry, skyBoxMaterial
			@scene.add skyBox
		setLight: ->
			light = new THREE.DirectionalLight 0xff8000, 1
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

		removeUnit: (unit) ->
			@collidables = _.reject @collidables, id: unit.id
			# if unit.collidable
			@scene.remove unit

		# isCanGo: (object, direction) ->
		# 	collisions = @countCollisions object, direction
		# 	for name, distance of collisions
		# 		if distance <1 then return no
		# 	yes

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

# return an array of collistion for defined object in defined dirrection
			findCollisions: (objects, direction)->
				collisions = {}
				for vertex,i in object.geometry.vertices
					localVertex = vertex.clone()
					globalVertex = vertex.clone().applyMatrix4 object.matrix
					directionPoint = vertex.clone().add(direction).applyMatrix4 object.matrix
					# directionVector = globalVertex.sub(object.position)
					directionVector = directionPoint.clone().sub(globalVertex).normalize()
					ray = new THREE.Raycaster( globalVertex, directionVector )
					intersections = ray.intersectObjects @collidables
					if intersections.length>0
						for intersection in intersections
							# console.log collision.distance, collision.object
							if collisions[intersection.object.name]
								if collisions[intersection.object.name] > intersection.distance
									collisions[intersection.object.name] = intersection.distance
							else collisions[intersection.object.name] = intersection.distance
					# @userRays[i].geometry.vertices[0] = globalVertex
					# @userRays[i].geometry.vertices[1] = directionPoint
					# @userRays[i].geometry.verticesNeedUpdate = yes
				# console.log _collisions
				collisions

]