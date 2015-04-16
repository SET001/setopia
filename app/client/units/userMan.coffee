app.factory 'UserMan', ['$rootScope', '$timeout', 'CubeMan', ($rootScope, $timeout, CubeMan) ->
	class window.UserMan extends CubeMan
		name: 'User'
		height: 5
		headRadius: 1
		mesh: null
		ready: yes
		collidable: no
		inJump: no
		canJump: no
		color: 0x0000ff
		
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