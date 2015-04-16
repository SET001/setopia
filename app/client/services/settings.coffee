app.service 'Settings', ['$cookieStore', '$location', ($cookieStore, $location) ->
	keyname = 'settings'
	data =
		username: ''

	if cookies = $cookieStore.get keyname
		data = _.assign data, cookies


	get: ->
		data
	save: ->
		$cookieStore.put keyname, data
		$location.path '/'
		console.log "saving settings..."

]