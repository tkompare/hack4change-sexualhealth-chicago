class User
	constructor:(data)->
		@age = data.age
		@sex = data.sex

	location:(data,cb)=>
		navigator.geoLocation.getCurrentPosition =>
			@location = 
				lat : position.coords.latitude
				lng : position.coords.longitude	
			cb(@) if cb?
		
	
window.User = User