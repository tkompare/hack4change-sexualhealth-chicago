class Question extends Spine.Model 
	@configure "Question", "text", "answer", "moreInfoUrl", 'tags'


	@fetch: ->
		console.log "have these questions ",require('models/questions')
		for question in require('models/questions')
			Question.create question 

	@filter:(categories)->
		@select (a) =>
			result = false 
			console.log a
			for catagory in categories
				for tag in a.tags
					if tag.match(catagory) 
						result =  true
			for catagory in categories
				for tag in a.text.split(" ")
					if tag.match(catagory) 
						result =  true
			result 

module.exports = Question
