app.factory 'Box', [ ->
	class window.Box
		path: 'box.jpg'
		name: 'Box'
		mesh: null
		collidable: yes
		ready: yes
		height: 5
		width: 5
		length: 5
		constructor: (init) ->
			texture = new THREE.ImageUtils.loadTexture 'images/box.jpg'
			material = new THREE.MeshLambertMaterial map: texture
			geometry = new THREE.BoxGeometry @length, @height, @width
			@mesh = new THREE.Mesh geometry, material
			@mesh.geometry.center()
			@mesh.geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0, -@mesh.geometry.boundingBox.min.y, 0))
			if init then init.call @
]