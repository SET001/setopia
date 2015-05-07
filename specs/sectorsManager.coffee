describe "SectorsManager", ->
	beforeEach ->
		module 'app'
		inject ($injector) ->
			window.SectorsManager = $injector.get 'SectorsManager'
			window.Config = $injector.get 'Config'
			window.BasicSectorSpawner = $injector.get 'BasicSectorSpawner'
		
	describe "`.calcNears`", ->
		sm = null
		beforeEach ->
			sm = new SectorsManager new BasicSectorSpawner()
		it 'should return correct number of sectors, depending on radius', ->
			point = new THREE.Vector2 0, 0
			sectorsCoords = sm.calcNears point
			expect(sectorsCoords.length).toBe 9
			sectorsCoords = sm.calcNears point, 2
			expect(sectorsCoords.length).toBe 25
			sectorsCoords = sm.calcNears point, 3
			expect(sectorsCoords.length).toBe 49
			sectorsCoords = sm.calcNears point, 4
			expect(sectorsCoords.length).toBe 81
		
		it 'should return valid sectors', ->
			expected = [
				[-1, -1], [-1, 0], [-1, 1]
				[0, -1], [0, 0], [0, 1]
				[1, -1], [1, 0], [1, 1]
			]
			x = Math.ceil(Math.random()*1000)
			y = Math.ceil(Math.random()*1000)
			point = new THREE.Vector2 x, y
			sectorsCoords = sm.calcNears point
			for sc, i in sectorsCoords
				expect(sc.x).toBe expected[i][0]+x
				expect(sc.y).toBe expected[i][1]+y
		it 'should return valid sectors in radius', ->
			expected = [
				[-2, -2], [-2, -1], [-2, 0], [-2, 1], [-2, 2]
				[-1, -2], [-1, -1], [-1, 0], [-1, 1], [-1, 2]
				[0, -2], [0, -1], [0, 0], [0, 1], [0, 2]
				[1, -2], [1, -1], [1, 0], [1, 1], [1, 2]
				[2, -2], [2, -1], [2, 0], [2, 1], [2, 2]
			]
			x = Math.ceil(Math.random()*1000)
			y = Math.ceil(Math.random()*1000)
			point = new THREE.Vector2 x, y
			sectorsCoords = sm.calcNears point, 2
			for sc, i in sectorsCoords
				expect(sc.x).toBe expected[i][0]+x
				expect(sc.y).toBe expected[i][1]+y

	describe "`.spawnNears`", ->
		sm = null
		beforeEach ->
			sm = new SectorsManager new BasicSectorSpawner()
		it 'should create new sectors', ->
			sm.spawnNears(new THREE.Vector2 0, 0)
			expect(sm.all().length).toBe(9)
		it 'should create new sectors in some radius', ->
			point = new THREE.Vector2 10, 10
			sm.spawnNears point, 2
			expect(sm.all().length).toBe(25)
		it 'should return spawned sectors', ->	
			point = new THREE.Vector2 10, 10
			sectors = sm.spawnNears point
			expect(sectors instanceof Array).toBeTruthy()
			expect(sectors.length).toBe 9
		it 'should not spawn alriedy spawned sectors', ->
			sm.spawnNears new THREE.Vector2 10, 10
			sectors = sm.spawnNears new THREE.Vector2 11, 10
			expect(sm.all().length).toBe 12
			expect(sectors.length).toBe 3

