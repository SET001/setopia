app.service 'Forest', ['Tree', (Tree) ->
# area - x1, y1, x2, y2	- coordinates of top left and bottom right points of area
	spawn: (count, area) ->
		# console.log "spawning forest with #{count} trees for area", area
		trees = new THREE.Object3D()
		for i in [1..count]
			tree = new Tree()
			x = area.x2-area.x1
			y = area.y2-area.y1
			tree.mesh.position.x = Math.random()*x+area.x1
			tree.mesh.position.z = Math.random()*y+area.y1
			# tree.mesh.position.x = area.x1+x/2
			# tree.mesh.position.z = area.y1+y/2
			trees.add tree.mesh
		trees
]