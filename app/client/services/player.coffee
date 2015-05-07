app.service 'Player', [ ->
	class Player
		sector: null
		model: null
		position: null	#	THREE.Vector3
		constructor: ->
		setModel: (model) ->
			@model = model
			@position = model.mesh.position
]