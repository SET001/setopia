app.service 'Controls', ['$rootScope', ($rootScope)->
	keyboard: null
	element: null
	enabled: no
	view: null
	velocity:null
	revTime: null
	canJump: yes
	init: (view) ->
		@revTime = performance.now()
		console.log "controls init"
		@velocity = new THREE.Vector3()
		@clock = new THREE.Clock()
		@view = view
		havePointerLock = 'pointerLockElement' of document || 'mozPointerLockElement' of document || 'webkitPointerLockElement' of document
		@element = document.body
		if havePointerLock
			@element.requestPointerLock = @element.requestPointerLock
			document.exitPointerLock = document.exitPointerLock || document.mozExitPointerLock || document.webkitExitPointerLock

			document.addEventListener 'pointerlockchange', =>
				@lockChange.call @
			, no
			document.addEventListener 'pointerlockerror', (error) ->
				console.log error
			, no
		else
			throw new Error "Your browser doesn't support Pointer Lock API!"

		@plc = new THREE.PointerLockControls @view.camera
		@view.scene.add @plc.getObject()
		@plc.getObject().rotation.y = -0.5
		@plc.getObject().position.x = 490
		@plc.getObject().position.y = 20
		@plc.getObject().position.z = 200
		@keyboard = new THREEx.KeyboardState()
		@
	enable: ->
		@element.requestPointerLock()
	lockChange: ->
		console.log "lockChange"
		if document.pointerLockElement is @element
			@enabled = yes
			@plc.enabled = yes
		else 
			@enabled = no
			@plc.enabled = no
		$rootScope.$apply()
	update: ->
		# delta = @clock.getDelta()
		time = performance.now()
		delta = ( time - @prevTime ) / 1000
		rotateAngle = Math.PI / 2 * delta   # pi/2 radians (90 degrees) per second
		directionVector = null
		if @enabled
			speed = 1
			directionVector = new THREE.Vector3()
			if @keyboard.pressed "shift"
				speed = 2
			if @keyboard.pressed "a"
				directionVector.add new THREE.Vector3 -speed, 0, 0
			if @keyboard.pressed "d"
				directionVector.add new THREE.Vector3 speed, 0, 0
			if @keyboard.pressed "w"
				directionVector.add new THREE.Vector3 0, 0, -speed
			if @keyboard.pressed "s"
				directionVector.add new THREE.Vector3 0, 0, speed
			# if @keyboard.pressed "ctrl"
			# 	$rootScope.$broadcast 'move', 'down'

			# 	@velocity.x += 1
			if @keyboard.pressed "space"
				if @canJump
					@velocity.y += 3
					@canJump = no

			@velocity.y -= 9.8 * delta
			if directionVector
				directionVector.add @velocity
				@plc.getObject().translateOnAxis directionVector, 1
			if @plc.getObject().position.y < 15
				@velocity.y = 0
				@canJump = yes
				@plc.getObject().position.y = 15
				# @plc.getObject().translateZ -1
				# object = @plc.getObject()
				# vertex = object.position()
				# 	localVertex = vertex.clone()

				# 	globalVertex = vertex.clone().applyMatrix4 object.matrix
				# 	directionPoint = vertex.clone().add(directionVector).applyMatrix4 object.matrix
				# 	# directionVector = globalVertex.sub(object.position)
				# 	directionVector = directionPoint.clone().sub(globalVertex).normalize()
				# 	ray = new THREE.Raycaster( globalVertex, directionVector )
				# 	collisions = ray.intersectObjects @view.collidables
				# 	if collisions.length>0 and collisions[0].distance <1
				# 		console.log "can't go"
				# 	else 
				# 		console.log "can go"
		@prevTime = time
]