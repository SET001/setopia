app.factory 'Fence', ['ModelCollidable', (ModelCollidable)->
	class window.Fence extends ModelCollidable
		path: 'fence2.json'
		name: 'Fence'
]