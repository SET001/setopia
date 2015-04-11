app.factory 'Fence', ['ModelCollidable', (ModelCollidable)->
	class window.Fence extends ModelCollidable
		path: 'models/fence2.json'
		name: 'Fence'
		setup: ->
			@mesh.scale.x = 0.5
			@mesh.scale.y = 0.5
			@mesh.scale.z = 0.5
			super()
]