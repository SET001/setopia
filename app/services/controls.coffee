app.service 'Controls', ['$rootScope', ($rootScope)->
	keyboard: null
	unit: null
	sy: 0
	element: null
	enabled: no
	init: (unit, camera) ->
		@clock = new THREE.Clock()

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
			document.addEventListener "mousemove", (e) =>
				@mousemove.call @, e
			, no
		else
			throw new Error "Your browser doesn't support Pointer Lock API!"

		@sy = 1
		@unit = unit
		@camera = camera
		@keyboard = new THREEx.KeyboardState()
		document.onmousedown = (e) =>
		document.onmouseup = (e) =>	
		document.onmousewheel = (e) =>
			speed = 4
			if e.wheelDelta > 0
				@sy += speed
			else 
				# if @sy>(-21+speed) then
				@sy -= speed
			@setCamera()
		@setCamera()
	mousemove: (e) ->
		if @enabled
			@unit.mesh.rotation.y -= e.movementX * 0.005
			# @camera.rotation.y -= e.movementX * 0.002
			# @unit.mesh.rotation.x -= e.movementY * 0.002
			# @unit.mesh.rotation.x = Math.max( - PI_2, Math.min( PI_2, pitchObject.rotation.x ) );
			# @unit.mesh.rotateOnAxis( new THREE.Vector3(0,1,0), -e.movementX*0.001)
			@setCamera()
			$rootScope.$broadcast 'move'
	enable: ->
		@element.requestPointerLock()
	lockChange: ->
		if document.pointerLockElement is @element
			@enabled = yes
		else 
			@enabled = no
		$rootScope.$apply()
	setCamera: ->
		relativeCameraOffset = new THREE.Vector3(50+@sy,20+@sy,0)
		cameraOffset = relativeCameraOffset.applyMatrix4 @unit.mesh.matrix
		@camera.position.x = cameraOffset.x
		@camera.position.y = cameraOffset.y
		@camera.position.z = cameraOffset.z
		@camera.lookAt new THREE.Vector3 @unit.position.x, @unit.position.y+10, @unit.position.z
	update: ->
		delta = @clock.getDelta()
		rotateAngle = Math.PI / 2 * delta   # pi/2 radians (90 degrees) per second
		moveDistance = 1
		if @enabled
			if @keyboard.pressed "A"
				$rootScope.$broadcast 'move', 'right'
			if @keyboard.pressed "D"
				$rootScope.$broadcast 'move', 'left'
			if @keyboard.pressed "W"
				$rootScope.$broadcast 'move', 'forward'
			if @keyboard.pressed "S"
				$rootScope.$broadcast 'move', 'backward'
			if @keyboard.pressed "ctrl"
				$rootScope.$broadcast 'move', 'down'
			if @keyboard.pressed "space"
				$rootScope.$broadcast 'move', 'up'
		@setCamera()
]