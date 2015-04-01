app.factory 'ModelCollidable', ['Model', '$q', (Model, $q)->
	class window.ModelCollidable extends Model
		collidable: yes
		setup: ->
			mesh = @mesh
			mesh.geometry.computeBoundingBox()

			material = new THREE.MeshBasicMaterial transparent: yes, opacity: 0
			geometry = new THREE.BoxGeometry @length, @height, @width
			@mesh = new THREE.Mesh geometry, material
			@mesh.geometry.center()
			@mesh.geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0, -@mesh.geometry.boundingBox.min.y, 0))
			@mesh.add mesh
			super()
]