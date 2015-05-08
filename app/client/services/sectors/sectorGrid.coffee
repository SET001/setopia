app.factory 'SectorGrid', ->
	class SectorGrid extends THREE.Line
		constructor: (cellWidth, cells) ->
			geometry = new THREE.Geometry()
			material = new THREE.LineBasicMaterial color: 0xffffff
			x = -parseInt(cellWidth*cells/2)
			y = 0.1
			for i in [0..cells]
			  geometry.vertices.push new THREE.Vector3 x+i*cellWidth, y, x
			  geometry.vertices.push new THREE.Vector3 x+i*cellWidth, y, x+cellWidth*cells

			  geometry.vertices.push new THREE.Vector3 x, y, x+i*cellWidth
			  geometry.vertices.push new THREE.Vector3 x+cellWidth*cells, y, x+i*cellWidth
			super geometry, material, THREE.LinePieces
