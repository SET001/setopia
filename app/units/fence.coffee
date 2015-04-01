app.factory 'Fence', ['ModelCollidable', (ModelCollidable)->
	class window.Fence extends ModelCollidable
		path: 'models/fence2.json'
		name: 'Fence'
]