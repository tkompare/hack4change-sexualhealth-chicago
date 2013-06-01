class Clinic

	constructor:(data)->
		@location = data.location
		@name =  data.name

	@fetch:=>
		$.getJSON 'https://data.cityofchicago.org/resource/ajzs-akmm.json', (data)=>
			console.log data

window.Clinic = Clinic