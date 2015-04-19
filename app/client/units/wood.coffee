app.factory 'Wood', ['Tree', (Tree) ->
	class window.Wood
		spawn: (count) ->
			worldWidth = 5000
			worldLength = 5000
			trees = new THREE.Object3D()
			for i in [1..count]
				tree = new Tree()
				tree.mesh.position.x = Math.random()*worldWidth-worldWidth/2
				tree.mesh.position.z = Math.random()*worldLength-worldLength/2
				trees.add tree.mesh
			trees
]