class window.Pig
	mesh: null
	constructor: ->
		loader = new THREE.JSONLoader()
		loader.load 'no_animation_pig.7.json', (geometry, materials) =>
			@mesh = new THREE.Mesh( geometry, new THREE.MeshLambertMaterial( color: 0xff007f ) )
			bb = new THREE.Box3().setFromObject(@mesh)
			@mesh.geometry.computeBoundingBox()
			height = @mesh.geometry.boundingBox.max.y - @mesh.geometry.boundingBox.min.y
			@mesh.geometry.center()
			@mesh.geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0, -@mesh.geometry.boundingBox.min.y, 0))
			@mesh.rotation.y = 1.5
			@mesh.position.set(10, 0, 0)
			@mesh.scale.set(1.5, 1.5, 1.5)
			console.log @mesh.geometry
			# THREE.AnimationHandler.add @mesh.geometry.animation
			# animation = new THREE.Animation @mesh, "ArmatureAction", THREE.AnimationHandler.CATMULLROM
			# animation.play()
