app.factory 'CubeMan', ['$rootScope', '$timeout', ($rootScope, $timeout) ->
	class window.CubeMan
		name: 'user'
		height: 5
		headRadius: 1
		mesh: null
		ready: yes
		collidable: no
		inJump: no
		canJump: no
		constructor: ->
			material = new THREE.MeshLambertMaterial color: 0xff0000
			bodyGeometry = new THREE.BoxGeometry 1, @height, 1
			@mesh = new THREE.Mesh bodyGeometry, material
			@mesh.name = "CubeMan body"
			@mesh.position.set 0, @height/2, 0
			@mesh.rotation.y = 0.3
			@mesh.castShadow = yes
			@mesh.receiveShadow = yes
			@position = @mesh.position

			handGeometry = new THREE.BoxGeometry 1, 1, 1
			leftHand = new THREE.Mesh handGeometry, material
			leftHand.position.set 0, 1, 1
			rightHand = new THREE.Mesh handGeometry, material
			rightHand.position.set 0, 1, -1

			headGeomtry = new THREE.SphereGeometry @headRadius, 20, 20
			head = new THREE.Mesh headGeomtry, material
			head.position.set 0, @height/2, 0

			@mesh.add head, leftHand, rightHand

		move: (direction) ->
			moveDistance = 1
			switch direction
				when 'forward' then	@mesh.translateX -moveDistance
				when 'backward' then @mesh.translateX moveDistance
				when 'right' then @mesh.translateZ +moveDistance
				when 'left' then @mesh.translateZ -moveDistance
				when 'down' 
					unless @inJump
						@mesh.translateY -moveDistance
				when 'up'
					unless @inJump
						@inJump = yes
						$timeout =>
							@inJump = no
						, 1000
					@mesh.translateY moveDistance

]