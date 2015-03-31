class window.Cow
	height: 3
	mesh: null
	constructor: ->
		material = new THREE.MeshLambertMaterial color: 0xff0000
		geometry = new THREE.BoxGeometry 7, 3, 3
		cow = new THREE.Mesh geometry, material
		cow.position.y = 4

		legGeometry = new THREE.BoxGeometry 1, 3, 1
		leg = new THREE.Mesh legGeometry, material 
		leg.position.x = 3
		leg.position.y = -2
		leg.position.z = 1
		cow.add leg

		leg = new THREE.Mesh legGeometry, material 
		leg.position.x = 3
		leg.position.y = -2
		leg.position.z = -1
		cow.add leg

		leg = new THREE.Mesh legGeometry, material 
		leg.position.x = -3
		leg.position.y = -2
		leg.position.z = -1
		cow.add leg

		leg = new THREE.Mesh legGeometry, material 
		leg.position.x = -3
		leg.position.y = -2
		leg.position.z = 1
		cow.add leg

		headGeomtry = new THREE.SphereGeometry 2, 20, 20
		head = new THREE.Mesh headGeomtry, material
		head.position.set -4, 2.5, 0
		cow.add head
		@mesh = cow