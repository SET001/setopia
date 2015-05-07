describe "Sector", ->
	beforeEach ->
		module 'app'
		inject ($injector) ->
			window.Sector = $injector.get 'Sector'
			window.Config = $injector.get 'Config'
			window.swidth = Config.sector.width
			window.slength = Config.sector.length

	it "should run", ->
		expect(1).toBe 1
		
	describe "`.at`", ->
		it 'should return correct position structure', ->
			sectorPos = Sector.at new THREE.Vector3 0, 0, 0
			expect(typeof(sectorPos)).toBe 'object'
			expect(sectorPos.x).toBeDefined()
			expect(sectorPos.y).toBeDefined()
			expect(isNaN(sectorPos.x)).toBeFalsy()
			expect(isNaN(sectorPos.y)).toBeFalsy()

		it 'should return correct sector number', ->
			sectorPos = Sector.at new THREE.Vector3 swidth/4, 0, slength/4
			expect(sectorPos.x).toBe(0)
			expect(sectorPos.y).toBe(0)
			sectorPos = Sector.at new THREE.Vector3 -swidth/4, 0, -slength/4
			expect(sectorPos.x).toBe(0)
			expect(sectorPos.y).toBe(0)
			sectorPos = Sector.at new THREE.Vector3 swidth/4, 0, -slength/4
			expect(sectorPos.x).toBe(0)
			expect(sectorPos.y).toBe(0)
			sectorPos = Sector.at new THREE.Vector3 -swidth/4, 0, slength/4
			expect(sectorPos.x).toBe(0)
			expect(sectorPos.y).toBe(0)
			sectorPos = Sector.at new THREE.Vector3 swidth/2+swidth/4, 0, slength/4
			expect(sectorPos.x).toBe(1)
			expect(sectorPos.y).toBe(0)

		it "left and bottom borders are included in sector", ->
			sectorPos = Sector.at new THREE.Vector3 -swidth/2, 0, 0
			expect(sectorPos.x).toBe(0)
			expect(sectorPos.y).toBe(0)
			sectorPos = Sector.at new THREE.Vector3 0, 0, -slength/2
			expect(sectorPos.x).toBe(0)
			expect(sectorPos.y).toBe(0)

		it "right and top borders are not included in sector", ->
			sectorPos = Sector.at new THREE.Vector3 swidth/2, 0, 0
			expect(sectorPos.x).toBe(1)
			expect(sectorPos.y).toBe(0)
			sectorPos = Sector.at new THREE.Vector3 0, 0, slength/2
			expect(sectorPos.x).toBe(0)
			expect(sectorPos.y).toBe(1)


		# it 'should ', ->
		# 	sector = new Sector -1, -1
		# 	near = sector.near {x:1, y: 1}
		# 	expect(near.x).toBe 1
		# 	expect(near.y).toBe 1

		# 	sector = new Sector 1, 1
		# 	near = sector.near {x:1, y: 1}
		# 	expect(near.x).toBe 2
		# 	expect(near.y).toBe 2