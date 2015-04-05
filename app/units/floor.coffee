app.factory 'Floor', ['$rootScope', '$timeout', ($rootScope, $timeout) ->
	class window.Floor
		name: 'Floor'
		width: 1000
		length: 1000
		mesh: null
		ready: yes
		collidable: yes
		texture: 'grass4.png'
		constructor: (settings) ->
			_.assign @, settings
			floorTexture = new THREE.ImageUtils.loadTexture "images/#{@texture}"
			floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping
			floorTexture.repeat.set 40, 40
			floorMaterial = new THREE.MeshLambertMaterial( { map: floorTexture, side: THREE.DoubleSide } )
			floorMaterial.receiveShadow = yes
			floorGeometry = new THREE.PlaneBufferGeometry @width, @length, 10, 10
			@mesh = new THREE.Mesh(floorGeometry, floorMaterial)
			@mesh.name = @name
			@mesh.receiveShadow = yes
			@mesh.position.y = 0
			@mesh.rotation.x = Math.PI / 2
]