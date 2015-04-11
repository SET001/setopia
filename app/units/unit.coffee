app.factory 'Unit', ['$q', ($q) ->
	class window.Unit
		constructor: (settings, customInit = null) ->
			@customInit = customInit
			@defer = $q.defer()
			@ready = @defer.promise
			@setup()
		setup: ->
			if @customInit 
				@customInit.call @
			@defer.resolve @
]