app.factory 'HillsTestView', (View, Config, Settings, Floor)	->
	class HillsTestView extends View
		setLight: ->
			light = new THREE.DirectionalLight 0xffffff, 1
			light.shadowMapWidth = 1024
			light.shadowMapHeight = 1024
			light.castShadow = yes
			light.position.set 50,100,50
			@scene.add light
			@scene.add new THREE.AmbientLight 0x555555
		init: ->
			super()
			img = document.getElementById("landscape-image")
			canvas = document.getElementById("canvas")
			canvas.width = img.width
			canvas.height = img.height
			canvas.getContext('2d').drawImage(img, 0, 0, img.width, img.height)

			data = canvas.getContext('2d').getImageData(0,0, img.height, img.width).data
			console.log "data length: #{data.length}"

			console.log "Creating surface plane..."
			geometry = new THREE.PlaneGeometry 5000, 5000, 500, 500
			console.log "Done with #{geometry.vertices.length} vertices"

			# j = 0
			# for i in [0..geometry.vertices.length-1]
			# 	geometry.vertices[i].z = (data[j])
			# 	j += 4
			geometry.computeFaceNormals()
			geometry.computeVertexNormals()
			console.log "vertices/faces normalised"

			grassTexture = new THREE.ImageUtils.loadTexture "images/grasslight-small.jpg"
			grassTexture.wrapS = grassTexture.wrapT = THREE.RepeatWrapping
			grassTexture.repeat.set 50, 50
			material = new THREE.MeshLambertMaterial
				color: 0x00ff00
				map: grassTexture
				# side: THREE.DoubleSide
				# wireframe: yes

			surface = new THREE.Mesh geometry, material
			surface.receiveShadow = yes
			surface.castShadow = yes
			surface.matrixAutoUpdate = yes
			surface.rotation.x = THREE.Math.degToRad 90
			surface.rotation.y = THREE.Math.degToRad 180
			surface.position.y = -100
			@scene.add surface

			waterG = new THREE.PlaneBufferGeometry 5000, 5000
			waterM = new THREE.MeshBasicMaterial
				opacity:0.40
				color: 0x0000ff
				transparent: yes
			water = new THREE.Mesh waterG, waterM
			water.rotation.x = THREE.Math.degToRad 90
			water.rotation.y = THREE.Math.degToRad 180
			water.position.y = -70
			@scene.add water