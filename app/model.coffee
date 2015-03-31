app.factory 'Model', ['$q', ($q) ->
	class window.Model
		path: ''
		name: ''
		mesh: null
		constructor: (customInit) ->
			defer = $q.defer()
			@ready = defer.promise
			loader = new THREE.JSONLoader()
			loader.load @path, (geometry, materials) =>
				@mesh = new THREE.Mesh( geometry, new THREE.MeshLambertMaterial( side: THREE.DoubleSide, shading: THREE.FlatShading ) )
				# @mesh = new THREE.Mesh( geometry, new THREE.MeshLambertMaterial( materials) )
				@mesh.name = @name
				bb = new THREE.Box3().setFromObject(@mesh)
				@mesh.geometry.computeBoundingBox()
				height = @mesh.geometry.boundingBox.max.y - @mesh.geometry.boundingBox.min.y
				@mesh.geometry.center()
				@mesh.geometry.applyMatrix(new THREE.Matrix4().makeTranslation(0, -@mesh.geometry.boundingBox.min.y, 0))
				defer.resolve()
			@ready.then =>
				@init()
				customInit.call @
				@
		init: ->
]