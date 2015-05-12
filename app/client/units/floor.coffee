app.factory 'Floor', ['$rootScope', '$timeout', 'Unit', ($rootScope, $timeout, Unit) ->
	class window.Floor extends Unit
		name: 'Floor'
		mesh: null
		ready: yes
		collidable: yes
		texture: 'grasslight-small.jpg'
		constructor: (settings, customInit = null) ->
			_.assign @, settings
			floorTexture = new THREE.ImageUtils.loadTexture "images/#{@texture}"
			# floorTexture.anisotropy = renderer.getMaxAnisotropy()
			floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping
			floorTexture.repeat.set 100, 100
			floorMaterial = new THREE.MeshLambertMaterial( { map: floorTexture, side: THREE.DoubleSide } )
			# floorMaterial = new THREE.MeshLambertMaterial( {color: 0xeeeeee, side: THREE.DoubleSide } )
			floorMaterial.receiveShadow = yes
			floorGeometry = new THREE.PlaneBufferGeometry @width, @length, 10, 10
			@mesh = new THREE.Mesh(floorGeometry, floorMaterial)
			@mesh.name = @name
			@mesh.receiveShadow = yes
			@mesh.position.y = 0
			@mesh.rotation.x = Math.PI / 2
			super settings, customInit
]