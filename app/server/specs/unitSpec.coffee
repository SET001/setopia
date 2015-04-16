World = require '../world'
TradeMan = require '../units/tradeMan'
RatMan = require '../units/ratMan'

_ = require 'lodash'

describe 'Unit', ->
	describe 'constructor', ->
		it 'should assign settings', ->
			man = new TradeMan
				foo: "bar"
				health: 1
			expect(man.foo).toBe "bar"
			expect(man.health).toBe 1

	describe 'export', ->
		it 'should not export rescricted proporties', ->
			world = new World()
			world.addUnit new TradeMan()
			keys = _.keys world.units[0].export()
			for deprecatedKey in ['world']
				expect((keys.indexOf deprecatedKey)>-1).toBeFalsy()

		it 'should contain keys', ->
			man = new TradeMan()
			man.name = "test"
			man.age = 123
			keys = _.keys man.export()
			expect((keys.indexOf "position")>-1).toBeTruthy()
			expect((keys.indexOf "health")>-1).toBeTruthy()
			expect((keys.indexOf "name")>-1).toBeTruthy()
			expect((keys.indexOf "age")>-1).toBeTruthy()
			expect((keys.indexOf "asdasdasd")>-1).toBeFalsy()

		it 'should not contain functions', ->
			man = new TradeMan()
			man.foo = -> 1
			keys = _.keys man.export()
			expect((keys.indexOf "foo")>-1).toBeFalsy()

		it 'should consider exports property', ->
			rat = new RatMan()
			keys = _.keys rat.export()
			expect(keys.length).toBe 2
			for key in rat.exports
				expect((keys.indexOf key)>-1).toBeTruthy()
			hiddenKeys = _.without.apply _, [(_.keysIn rat)].concat rat.exports
			for key in hiddenKeys
				expect((keys.indexOf key)>-1).toBeFalsy()