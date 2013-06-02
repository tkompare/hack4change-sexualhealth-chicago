class Fact extends Spine.Model 
	@configure "Fact", "text", "category"

	@fetch: ->
		for fact in require('models/facts')
			@create fact 

	@selectRandom:->
		total = @count()
		selection = Math.floor( Math.random() * total)
		@all()[selection]

module.exports = Fact
