app.factory 'CubeMan', ['$rootScope', '$timeout', ($rootScope, $timeout) ->
	class window.CubeMan
		name: 'CubeMan'
		username: ''
		height: 5
		headRadius: 1
		mesh: null
		id: null
		ready: yes
		collidable: no
		color: 0xeee
		constructor: (settings) ->
			_.assign @, settings
			material = new THREE.MeshLambertMaterial color: @color
			bodyGeometry = new THREE.BoxGeometry 1, @height, 1
			@mesh = new THREE.Mesh bodyGeometry, material
			@mesh.name = "CubeMan body"
			@mesh.position.set 0, @height/2, 0
			@mesh.rotation.y = 0.3
			@mesh.castShadow = yes
			@mesh.receiveShadow = yes
			@position = @mesh.position

			handGeometry = new THREE.BoxGeometry 1, 1, 1
			leftHand = new THREE.Mesh handGeometry, material
			leftHand.position.set 0, 1, 1
			rightHand = new THREE.Mesh handGeometry, material
			rightHand.position.set 0, 1, -1

			headGeomtry = new THREE.SphereGeometry @headRadius, 20, 20
			head = new THREE.Mesh headGeomtry, material
			head.position.set 0, @height/2, 0

			# textGeo = new THREE.TextGeometry "asdasd",
			# 	size: 10
			# 	height: 10
			# 	# curveSegments: curveSegments

			# 	# font: font,
			# 	# weight: weight,
			# 	# style: style,

			# 	# bevelThickness: bevelThickness,
			# 	# bevelSize: bevelSize,
			# 	# bevelEnabled: bevelEnabled,

			# 	# material: 0
			# 	# extrudeMaterial: 1
			# text = new THREE.Mesh textGeo, material
			# text.position.y = 2



			@mesh.add head, leftHand, rightHand
]