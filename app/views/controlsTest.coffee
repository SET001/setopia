app.factory 'ControlsTestView', ['$rootScope','$q', '$injector', 'View', 'Config', 'Settings', 'Designer', 'UserMan', 'House', 'Ninja', 'Fence', 'Tree', 'Floor', 'Shack'
, ($rootScope, $q, $injector, View, Config, Settings, Designer, UserMan, House, Ninja, Fence, Tree, Floor, Shack)	->
	class ControlsTestView extends View
		init: ->
			super()
			shack = new Shack()
			shack.ready.then =>
				shack.mesh.position.x = 500
				shack.mesh.position.y = 0
				shack.mesh.position.z = 250
				scale = 3
				shack.mesh.scale.x = scale
				shack.mesh.scale.y = scale
				shack.mesh.scale.z = scale
				shack.mesh.rotation.y = 3
				shack.mesh.receiveShadow = yes
				shack.mesh.castShadow = yes
				@collidables.push shack.mesh
				@scene.add shack.mesh
				@units.push shack
			house = new House()
			house.ready.then =>
				house.mesh.position.x = 500
				house.mesh.position.y = 0
				house.mesh.position.z = 100
				scale = 3
				house.mesh.scale.x = scale
				house.mesh.scale.y = scale
				house.mesh.scale.z = scale
				house.mesh.receiveShadow = yes
				house.mesh.castShadow = yes
				@collidables.push house.mesh
				@scene.add house.mesh
				@units.push house
			ninja = new Ninja()
			ninja.ready.then =>
				ninja.mesh.castShadow = yes
				ninja.mesh.rotation.y = -1
				scale = 3
				ninja.mesh.scale.x = scale
				ninja.mesh.scale.y = scale
				ninja.mesh.scale.z = scale
				ninja.mesh.position.x = 520
				ninja.mesh.position.y = 0
				ninja.mesh.position.z = 150
				@collidables.push ninja.mesh
				@scene.add ninja.mesh
				@units.push ninja

			fence2 = new Fence()
			fence2.ready.then =>
				# fence.mesh.rotation.y = 0
				fence2.mesh.position.x = 550
				fence2.mesh.position.y = 0
				fence2.mesh.position.z = 160
				@collidables.push fence2.mesh
				@scene.add fence2.mesh
				@units.push fence2
			fence3 = new Fence()
			fence3.ready.then =>
				# fence.mesh.rotation.y = 0
				console.log fence3.length, fence3.height, fence3.width
				fence3.mesh.position.x = 550+12
				fence3.mesh.position.y = 0
				fence3.mesh.position.z = 160
				@collidables.push fence3.mesh
				@scene.add fence3.mesh
				@units.push fence3

			fence = new Fence()
			fence.ready.then =>
				fence.mesh.rotation.y = -1.5
				fence.mesh.position.x = 400
				fence.mesh.position.y = 0
				fence.mesh.position.z = 100
				@collidables.push fence.mesh
				@scene.add fence.mesh
				@units.push fence

			@user = new UserMan
			@user.position.y = 20
			@user.position.z = 20
			@user.position.x = 20
			@user.mesh.rotation.y = 0.1
			@scene.add @user.mesh

			# floor = new Floor
			# 	width: 10000
			# 	length: 10000
			# floor.ready.then =>
			# 	@collidables.push floor.mesh
			# 	@scene.add floor.mesh
			# 	@units.push floor
	
]