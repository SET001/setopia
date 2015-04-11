app.factory 'RatMan', ['CubeMan', (CubeMan) ->
	class window.RatMan extends CubeMan
		name: 'RatMan'
		height: 3
		headRadius: 1
		ready: yes
		collidable: yes
		color: 0xff0000
]