app.factory 'ForestTestView', ['$rootScope','$q', '$injector', 'View', 'Config', 'Settings', 'Forest', 'Floor', 'UserMan'
, ($rootScope, $q, $injector, View, Config, Settings, Forest, Floor, UserMan)	->
	class ForestTestView extends View
		init: ->
			super()
			@user = new UserMan
			@user.position.y = 20
			@user.position.z = 0
			@user.position.x = 0
			# @user.mesh.rotation.y = 0.1
			@scene.add @user.mesh

			floor = new Floor
				width: 10000
				length: 10000
			floor.ready.then =>
				@collidables.push floor.mesh
				@scene.add floor.mesh
				@units.push floor
			forest = new Forest()
			trees = forest.spawn 1000
			@scene.add trees
			# @scene.fog = new THREE.Fog 0x050505, 1000, 4000
			# @scene.fog.color.setHSL( 0.1, 0.5, 0.5 )
			# @renderer.setClearColor( @scene.fog.color )
	
]