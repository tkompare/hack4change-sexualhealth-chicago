class Clinic
	
	constructor:(data)->
		@location = data.location
		@name =  data.name

	fetch:=>
		$.getJSON 'https://data.cityofchicago.org/api/views/ajzs-akmm.json?callback=?', (data)=>
			console.log data

window.Clinic = Clinic