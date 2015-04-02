app.factory 'Controls', ['$rootScope', ($rootScope)->
	class window.Controls
		oldX: 0
		keyboard: null
		unit: null
		sy: 0
		constructor: (unit, camera) ->
			havePointerLock = 'pointerLockElement' of document || 'mozPointerLockElement' of document || 'webkitPointerLockElement' of document
			if havePointerLock
			else
				throw new Exception "Your browser doest's dussport Pointer Lock API!"
			# document.requestPointerLock()
			console.log havePointerLock

			@clock = new THREE.Clock()
			@sy = 1
			@unit = unit
			@camera = camera
			@keyboard = new THREEx.KeyboardState()
			document.onmousemove = (e) =>
				angle = .03
				# console.log Math.abs @oldX-e.x
				angle *= (Math.abs @oldX-e.x) / 3
				if @oldX > e.x
					@unit.mesh.rotateOnAxis( new THREE.Vector3(0,1,0), angle)
				if @oldX < e.x
					@unit.mesh.rotateOnAxis( new THREE.Vector3(0,1,0), -angle)
				@oldX = e.x
				$rootScope.$broadcast 'move'
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
		setCamera: =>
			relativeCameraOffset = new THREE.Vector3(50+@sy,20+@sy,0)
			cameraOffset = relativeCameraOffset.applyMatrix4 @unit.mesh.matrixWorld
			@camera.position.x = cameraOffset.x
			@camera.position.y = cameraOffset.y
			@camera.position.z = cameraOffset.z
			@camera.lookAt new THREE.Vector3 @unit.position.x, @unit.position.y+10, @unit.position.z
		update: =>
			delta = @clock.getDelta()
			rotateAngle = Math.PI / 2 * delta   # pi/2 radians (90 degrees) per second
			moveDistance = 1
			if @keyboard.pressed "A"
				$rootScope.$broadcast 'move', 'right'
				# @unit.mesh.rotateOnAxis( new THREE.Vector3(0,1,0), rotateAngle)
			if @keyboard.pressed "D"
				# @unit.mesh.rotateOnAxis( new THREE.Vector3(0,1,0), -rotateAngle)
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