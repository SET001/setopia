app.factory 'Ninja', ['Model', (Model)->
	class window.Ninja extends Model
		path: 'models/ninja.json'
		name: 'Ninja'
		shading: THREE.SmoothShading
]