app.factory 'Model', ['$q', ($q) ->
	class window.Model
		path: ''
		name: ''
		mesh: null
		height: 0
		width: 0
		length: 0
		collidable: no
		@defer: null
		shading: THREE.FlatShading
		constructor: (customInit) ->
			@customInit = customInit
			@defer = $q.defer()
			@ready = @defer.promise
			loader = new THREE.JSONLoader()
			loader.load @path, (geometry, materials) =>

				@mesh = new THREE.Mesh( geometry, new THREE.MeshLambertMaterial( side: THREE.DoubleSide, shading: @shading) )
				@mesh.name = @name
				@mesh.geometry.computeBoundingBox()
				@mesh.geometry.center()
				@mesh.geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0, -@mesh.geometry.boundingBox.min.y, 0))

				@height = @mesh.geometry.boundingBox.max.y - @mesh.geometry.boundingBox.min.y
				@width = @mesh.geometry.boundingBox.max.z - @mesh.geometry.boundingBox.min.z
				@length = @mesh.geometry.boundingBox.max.x - @mesh.geometry.boundingBox.min.x
				@setup()
		setup: ->
			if @customInit 
				@customInit.call @
			@defer.resolve @

]