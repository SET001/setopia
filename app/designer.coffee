app.factory 'Designer', ['$q', ($q) ->
	class window.Designer
		cursor: null
		unitClass: null
		scene: null
		constructor: (unitClass, scene) ->
			@cursor = new THREE.Mesh()
			@unitClass = unitClass
			@scene = scene

		go: (x, y, z) ->
			@cursor.position.set x, y, z
			@
		line: (count) ->
			for i in [1..count]
				unit = new @unitClass()
				$q.when(unit.ready).then =>
					unit.mesh.position.x = @cursor.position.x
					unit.mesh.position.y = @cursor.position.y
					unit.mesh.position.z = @cursor.position.z
					# unit.mesh.applyMatrix @cursor.matrix
					@cursor.position.x += unit.length
					@scene.add unit.mesh
			@

]