app.factory 'Tree', ['$q', 'Unit', ($q, Unit) ->
	treeTexture = new THREE.ImageUtils.loadTexture 'images/tree.jpg'
	material = new THREE.MeshLambertMaterial map: treeTexture

	leavesTexture = new THREE.ImageUtils.loadTexture 'images/leaves.jpg'
	leavesMaterial = new THREE.MeshLambertMaterial map: leavesTexture, side: THREE.DoubleSide

	class window.Tree extends Unit
		name: 'tree'
		maxHeight: 120
		minHeight: 20
		radius: 1
		leavesRadius: 4
		sceneObjects: []
		position: null
		mesh: null
		constructor: (settings, customInit = null) ->
			@height = (Math.ceil Math.random()*(@maxHeight-@minHeight)) + @minHeight
			@leavesRadius = (Math.ceil Math.random()*@height/2) + @height/4
			@radius = (Math.ceil Math.random()*@height/10) + @height/20
			
			geometry = new THREE.CylinderGeometry @radius, @radius, @height, 32, 32
			@mesh = new THREE.Mesh geometry, material
			@mesh.castShadow = true
			@mesh.receiveShadow = true
			@mesh.position.set 0, @height/2, 0

			
			leavesGeometry = new THREE.SphereGeometry @leavesRadius, 32, 16, 0, 2 * Math.PI, 0, Math.PI / 2
			leaves = new THREE.Mesh leavesGeometry, leavesMaterial
			leaves.castShadow = true
			leaves.receiveShadow = true
			leaves.position.set 0, @height/2-1, 0
			leavesBottomGeometry = new THREE.CircleGeometry @leavesRadius, 32
			leavesBottom = new THREE.Mesh leavesBottomGeometry, leavesMaterial
			leavesBottom.rotation.x = 1.58
			leavesBottom.position.y = @height/2 + 0.5

			@mesh.add leaves, leavesBottom
			super settings, customInit
]