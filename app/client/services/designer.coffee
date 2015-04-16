app.factory 'Designer', ['$q', ($q) ->
	class window.Designer
		cursor: null
		unitClass: null
		units: []
		constructor: (unitClass) ->
			@cursor = new THREE.Mesh()
			@unitClass = unitClass
			@unit = new @unitClass()
			@ready = @unit.ready

		go: (x, y, z) ->
			@cursor.position.set x, y, z
			@
		line: (count) ->
			for i in [1..count]
				unit = new @unitClass()
				unit.mesh.position.x = @cursor.position.x
				unit.mesh.position.y = @cursor.position.y
				unit.mesh.position.z = @cursor.position.z
				# unit.mesh.applyMatrix @cursor.matrix
				@cursor.position.x += unit.length
				@units.push unit
			@
		lineUp: (count) ->
			for i in [1..count]
				unit = new @unitClass()
				unit.mesh.position.x = @cursor.position.x
				unit.mesh.position.y = @cursor.position.y
				unit.mesh.position.z = @cursor.position.z
				# unit.mesh.applyMatrix @cursor.matrix
				@cursor.position.y += unit.length
				@units.push unit
			@

]