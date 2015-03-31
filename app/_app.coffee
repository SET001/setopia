window.stime = (new Date()).getTime()

t = THREE
$ ->
	app = new App()
	app.animate()

class App
	units: []
	constructor: ->
		@scene = new t.Scene()
		@renderer = new t.WebGLRenderer()
		@renderer.setSize window.innerWidth, window.innerHeight
		@renderer.shadowMapEnabled = yes
		document.body.appendChild @renderer.domElement
		@setCamera()

		window.addEventListener 'resize', =>
			width = window.innerWidth
			height = window.innerHeight
			@renderer.setSize width, height
			@camera.aspect = width / height
			@camera.updateProjectionMatrix()

		if Config.enableAxis
			axes = new t.AxisHelper 10
			@scene.add axes

		skyBoxGeometry = new THREE.SphereGeometry 1280, 100, 100
		skyBoxTexture = new THREE.ImageUtils.loadTexture 'images/sky3.jpg'
		skyBoxTexture.wrapS = skyBoxTexture.wrapT = THREE.RepeatWrapping
		skyBoxTexture.repeat.set 8, 8
		skyBoxMaterial = new THREE.MeshBasicMaterial map: skyBoxTexture, side: THREE.DoubleSide
		skyBox = new THREE.Mesh skyBoxGeometry, skyBoxMaterial
		@scene.add skyBox


		@setLight()
		@setFloor()
		@setStats()
		# 	====================
		@user = new CubeMan
		# @user.position.y = 0
		@user.position.z = 10
		@user.position.x = 10
		@user.mesh.rotation.y = 0.1
		@camera.position.set @user.position.x - 35, @user.position.y + 25, @user.position.z
		@camera.lookAt @user.position
		@addUnit @user
		console.log @countCollisions @user.mesh

		# @spawnUnits Tree, 100
		# @spawnUnits Cow, 1
		@spawnUnits Pig, 1, no
		@controls = new Controls @user, @camera
		window.stime -= (new Date()).getTime()
		console.log "Done in #{(window.stime*-1)/1000} seconds"
	setLight: ->
		light = new THREE.DirectionalLight 0xffffff, 1
		# light = new THREE.SpotLight 0xffffff
		light.castShadow = yes
		light.position.set(400,400,400)
		@scene.add light
		@scene.add new THREE.AmbientLight 0x555555
		
		# @renderer.shadowMapEnabled = true
  #   @renderer.shadowMapSoft = false

  #   @renderer.shadowCameraNear = 3
  #   @renderer.shadowCameraFar = @camera.far
  #   @renderer.shadowCameraFov = 50

  #   @renderer.shadowMapBias = 0.0039
  #   @renderer.shadowMapDarkness = 0.5
  #   @renderer.shadowMapWidth = 1024
  #   @renderer.shadowMapHeight = 1024
	setFloor: ->
		floorTexture = new THREE.ImageUtils.loadTexture 'images/grass4.png'
		floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping
		floorTexture.repeat.set 40, 40
		floorMaterial = new THREE.MeshLambertMaterial( { map: floorTexture, side: THREE.DoubleSide } )
		floorMaterial.receiveShadow = yes
		floorGeometry = new THREE.PlaneBufferGeometry 2560, 2560, 10, 10
		floor = new THREE.Mesh(floorGeometry, floorMaterial)
		floor.receiveShadow = yes
		floor.position.y = 0
		floor.rotation.x = Math.PI / 2
		@scene.add(floor)

	animate: (t) =>
		requestAnimationFrame @animate

		# @controls.update @camera

		@controls.update()
		@stats.update()
		@render()

	countCollisions: (object) =>
		collisions = []
		originPoint = object.position.clone()
		for vertex, i in object.geometry.vertices
			localVertex = vertex.clone()
			globalVertex = localVertex.applyMatrix4 object.matrix 
			directionVector = globalVertex.sub object.position
			ray = new THREE.Raycaster originPoint, directionVector.clone().normalize()
			collisionResults = ray.intersectObjects @units
			collisions.push collisionResults.length
				# if ( collisionResults.length > 1 && collisionResults[0].distance < directionVector.length() ) 
				# return true
		collisions
	checkHit: (object, r) =>
		originPoint = object.position.clone()
		originPoint.z += r
		for vertex, i in object.geometry.vertices
			localVertex = vertex.clone()
			globalVertex = localVertex.applyMatrix4 object.matrix 
			directionVector = globalVertex.sub object.position
			ray = new THREE.Raycaster originPoint, directionVector.clone().normalize()
			collisionResults = ray.intersectObjects @units
			if ( collisionResults.length > 1 && collisionResults[0].distance < directionVector.length() ) 
				return true
		return false

	render: =>
		@renderer.render @scene, @camera
	update: =>
		
	setStats: =>
		@stats = new Stats()
		@stats.domElement.style.position = 'absolute'
		@stats.domElement.style.left = '0px'
		@stats.domElement.style.top = '0px'
		document.body.appendChild @stats.domElement
	setCamera: (to) =>
		@camera = new t.PerspectiveCamera 45, window.innerWidth / window.innerHeight, 0.1, 20000
		@camera.position.set Config.camera.x, Config.camera.y, Config.camera.z
		@camera.lookAt @scene.position

	addUnit: (unit) =>
		@units.push unit.mesh
		@scene.add unit.mesh
	randPos: ->
		max = 500
		(Math.ceil Math.random()*max) - max/2
	spawnUnits: (UnitClass, count, randPos=yes) ->
		for i in [1..count]
			unit = new UnitClass()
			if randPos
				unit.mesh.position.x = @randPos()
				unit.mesh.position.z = @randPos()
			setTimeout =>
				console.log unit
				@addUnit unit
			, 1000