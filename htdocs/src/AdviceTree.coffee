class AdviceTree

	constructor:->
		@relevant_to_gender ||= ['male', 'female']
		@relevant_to_oritentation ||= ['gay', 'straight', 'bisexual']

	
window.AdviceTree= AdviceTree