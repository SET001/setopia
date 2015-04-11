app.service 'World', ['$q', 'Designer', 'Box', ($q, Designer, Box) ->
	units: []
	promises: []
	ready: null
	init: ->
		@ready = $q.defer()
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
		@units.push
			collidable: yes
			mesh: floor
			ready: yes

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
			@units.concat designer.units

		defer = $q.defer()
		# @units.push new Fence ->
		# 	@mesh.position.set 10, 0, 10
		# @units.push new FenceCenter ->
		# 	@mesh.position.set 2, 1.5, 10
		# @units.push new FenceCenter ->
		# 	@mesh.position.set -5.4, 1.5, 10
		# @units.push new Fence ->
		# 	@mesh.position.set -13.5, 0, 10
		# @units.push new FenceCenter ->
		# 	@mesh.position.set 30, 0, -50			
		# 	@mesh.scale.set 10, 10, 10
		# @units.push new Fence ->
		# 	@mesh.position.set 150, 0, -50			
		# 	@mesh.scale.set 10, 10, 10

		# map = [
		# 	[0, 0, 100]
		# 	[5, 0, 100]
		# 	[10, 0, 100]
		# 	[10, 5, 100]
		# 	[15, 0, 100]
		# 	[15, 5, 100]
		# 	[15, 10, 100]
		# ]
		# material = new THREE.MeshBasicMaterial color: 0x000000
		# geometry = new THREE.BoxGeometry 5, 5, 5
		
		# for item in map
		# 	@units.push new Box ->
		# 		@mesh.position.x = item[0]
		# 		@mesh.position.y = item[1]
		# 		@mesh.position.z = item[2]

		$q.all(@promises).then =>
			@ready.resolve @units
		@ready.promise
]