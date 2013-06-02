Fact = require('models/Fact')

class FactController extends Spine.Controller 
	className: "factController"

	events:
		".cross click": "back"


	constructor:->
		super 
		@counter = 0
		Fact.fetch()
		Spine.Route.bind 'change',=>
			@counter += 1 
			if @counter == 3 
				@counter = 0 
				@navigate('/fact')

	active:=>
		super
		@render()

	render:=>
		@html require('views/fact')
			fact : Fact.selectRandom()

	back:=>
		history.go(-1)

module.exports = FactController