app.factory 'Fence', ['ModelCollidable', (ModelCollidable)->
	class window.Fence extends ModelCollidable
		path: 'models/fence2.json'
		name: 'Fence'
		setup: ->
			scale = 1.5
			@mesh.scale.x = scale
			@mesh.scale.y = scale
			@mesh.scale.z = scale
			super()
]