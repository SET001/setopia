app.factory 'Tree', ['$q', 'Unit', ($q, Unit) ->
	height = 100
	radius = 5
	leavesRadius = 50


	leavesTexture = new THREE.ImageUtils.loadTexture 'images/leaves.jpg'
	# leavesMaterial = new THREE.MeshLambertMaterial map: leavesTexture, side: THREE.DoubleSide
	leavesMaterial = new THREE.MeshLambertMaterial map: leavesTexture
	leavesMaterial.visible = yes
	

	treeTexture = new THREE.ImageUtils.loadTexture 'images/tree.jpg'
	material = new THREE.MeshLambertMaterial map: treeTexture
	material.visible = yes

	geometries = []

	proportions =
		# leaves: [40, 150, 25]
		# trees: [7, 20, 4]
		leaves: [25]
		trees: [4]
	for i, k in proportions.trees
		geometries.push 
			tree: new THREE.CylinderGeometry i, i, 10*i, 32, 32
			leaves: new THREE.SphereGeometry proportions.leaves[k], 64, 64, 0, 2 * Math.PI, 0, Math.PI / 2
			leavesBottom: new THREE.CircleGeometry proportions.leaves[k], 64
	
	class window.Tree extends Unit
		name: 'tree'
		sceneObjects: []
		position: null
		mesh: null
		constructor: (settings, customInit = null) ->
			geometry = @getRandomGeometry()
			@mesh = new THREE.Mesh geometry.tree, material
			@mesh.geometry.center()
			@mesh.geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0, -@mesh.geometry.boundingBox.min.y, 0))
			@height = @mesh.geometry.boundingBox.max.y - @mesh.geometry.boundingBox.min.y
			@mesh.castShadow = true
			@mesh.receiveShadow = true
			@mesh.matrixAutoUpdate = yes
			# @mesh.updateMatrix()
			
			h = Math.random()*20+2
			leaves = new THREE.Mesh geometry.leaves, leavesMaterial
			leaves.castShadow = true
			leaves.receiveShadow = true
			leaves.position.y = @height-h
			
			leavesBottom = new THREE.Mesh geometry.leavesBottom, leavesMaterial
			leavesBottom.position.y = @height-h
			leavesBottom.rotation.x = THREE.Math.degToRad 90
			# leavesBottom.rotation.x = 244.64536456131407

			@mesh.add leaves, leavesBottom
			super settings, customInit
		getRandomGeometry: () ->
			index = parseInt(Math.random()*geometries.length);
			geometries[index]
]