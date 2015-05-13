app.factory 'HillsTestView', (View, Config, Settings, Floor)	->
	class HillsTestView extends View
		setLight: ->
			light = new THREE.DirectionalLight 0xffffff, 1
			light.shadowMapWidth = 1024
			light.shadowMapHeight = 1024
			light.castShadow = yes
			light.position.set 50,100,50
			@scene.add light
		init: ->
			super()
			img = document.getElementById("landscape-image")
			canvas = document.getElementById("canvas")
			canvas.width = img.width
			canvas.height = img.height
			canvas.getContext('2d').drawImage(img, 0, 0, img.width, img.height)

			data = canvas.getContext('2d').getImageData(0,0, img.height, img.width).data

			geometry = new THREE.PlaneGeometry 1000, 1000, 249, 249
			j = 0
			for i in [0..geometry.vertices.length-1]
				geometry.vertices[i].z = -(data[j]/10)
				j += 4

			geometry.computeFaceNormals()
			geometry.computeVertexNormals()

			floorTexture = new THREE.ImageUtils.loadTexture "images/grasslight-small.jpg"
			floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping
			floorTexture.repeat.set 50, 50
			material = new THREE.MeshLambertMaterial
				color: 0x00ff00
				map: floorTexture
				# side: THREE.DoubleSide
				# wireframe: yes

			surface = new THREE.Mesh geometry, material
			surface.receiveShadow = yes
			surface.castShadow = yes
			surface.matrixAutoUpdate = yes
			surface.rotation.x = THREE.Math.degToRad 90
			surface.rotation.y = THREE.Math.degToRad 180
			surface.position.y = - 5
			@scene.add surface

			g = new THREE.CylinderGeometry 10, 10, 10, 32, 32
			mesh = new THREE.Mesh g, material
			mesh.position.set 0, 0, -20
			@scene.add mesh
