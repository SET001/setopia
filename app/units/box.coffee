app.factory 'Box', ['$q', ($q) ->
	length = 5
	height = 5
	width = 5
	texture = new THREE.ImageUtils.loadTexture 'images/box.jpg'
	material = new THREE.MeshLambertMaterial map: texture
	geometry = new THREE.BoxGeometry length, height, width
	
	class window.Box
		path: 'box.jpg'
		name: 'Box'
		mesh: null
		collidable: yes
		ready: no
		height: height
		width: width
		length: length
		constructor: (init) ->
			defer = $q.defer()
			@ready = defer.promise
			@mesh = new THREE.Mesh geometry, material
			@mesh.castShadow = yes
			@mesh.receiveShadow = yes
			@mesh.geometry.center()
			@mesh.geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0, -@mesh.geometry.boundingBox.min.y, 0))
			if init then init.call @
			defer.resolve @
]