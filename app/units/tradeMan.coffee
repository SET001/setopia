app.factory 'TradeMan', ['$rootScope', '$timeout', 'CubeMan', ($rootScope, $timeout, CubeMan) ->
	class window.TradeMan extends CubeMan
		name: 'User'
		height: 7
		headRadius: 1.5
		ready: yes
		collidable: yes
		color: 0x00ff00
]