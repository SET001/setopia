app.factory 'Box', [ ->
	class window.Box
		path: 'box.jpg'
		name: 'Box'
		mesh: null
		collidable: yes
		ready: yes
		constructor: (init) ->
			texture = new THREE.ImageUtils.loadTexture 'images/box.jpg'
			material = new THREE.MeshLambertMaterial map: texture
			geometry = new THREE.BoxGeometry 5, 5, 5
			@mesh = new THREE.Mesh geometry, material
			if init then init.call @
]