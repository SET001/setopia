app.factory 'Fence', ['Model', (Model)->
	class window.Fence extends Model
		collidable: yes
		path: 'fence2.json'
		name: 'Fence'
		mesh: null
		init: ->
			scale = 1
			@mesh.scale.set scale, scale, scale
]