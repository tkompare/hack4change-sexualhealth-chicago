class Clinic

	constructor:(data)->
		console.log "creating with ", data
		@[key] = val for key, val of data 
		# getReviews()

	getReviews:=>
		$.getJSON("")

	@fetch:=>
		$.getJSON 'https://data.cityofchicago.org/resource/ajzs-akmm.json', (data)=>
			clinics = (new Clinic(clinic) for clinic in data)
			Clinic.all = clinics
			console.log "clinics are ", clinics
			# @renderClinicList()

	@renderClinicList:=>
		for clinic in Clinic.all
			$("#clinicList ul").append("<li>#{clinic.name}</li>")


	addToMap:(map)=>

	setCurrent:=>

	sendReview:(raiting,comment)=>
		$.post '/addReview',
			clinic: @
			review:
				raiting: raiting
				comment: comment 


window.Clinic = Clinic