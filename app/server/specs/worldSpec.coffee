World = require '../world'
TradeMan = require '../units/tradeMan'
_ = require 'lodash'

describe 'World', ->

	# describe 'loading world', ->

	# 	it 'should throw error when can`t read world file', ->
	# 		expect(world.load("asd")).toThrow(new Error "Failed to open world file !")

	it 'should be created in empty state (empty arrays)', ->
		world1 = new World()
		world1.addUnit new TradeMan()
		world2 = new World()
		expect(world2.units.length).toBe 0

	it 'should remove unit', ->
		world = new World()
		world.addUnit new TradeMan()
		world.addUnit new TradeMan()
		world.removeUnit id: 1
		expect(world.units.length).toBe 1