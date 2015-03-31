app.factory 'FenceCenter', ['Model', (Model)->
	class window.FenceCenter extends Model
		collidable: yes
		path: 'fence2_center.json'
		name: 'FenceCenter'
		init: ->
			@mesh.scale.set(1, 1, 1)
]