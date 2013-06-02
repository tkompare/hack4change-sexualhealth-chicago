Question= require('models/Question')

class QuestionController extends Spine.Controller
  className: "questionController"

  events:
    'click .addmore' : "addmore"
    'keyup input'    : "updateFilter"
    'click .pointer' : "showClinics"

  elements:
    '.matches' : "matchList"


  constructor: ->
    super
    @render()
    Question.fetch()

  addmore:=>
    @filters.push ""
    @render()

  showClinics:=>
    @navigate('/clinics')

  updateFilter:(e)=>
    index = $(e.currentTarget).data().index 
    @filters[index] = $(e.currentTarget).val()
    @current_questions = Question.filter @filters
    @renderQuestions()
    
  active:(params)=>
    super
    @filters = params.filters?.split(",")
    @filters ||= []

    if @filters.length==0
      @current_questions = Question.all()
    else
      @current_questions = Question.filter @filters

    @render()
    

  renderQuestions:=>
    @matchList.html require('views/matches')
      questions : (@current_questions || [])


  render:=>
    @html require('views/question')
      questions : (@current_questions || [])
      filters   : (@filters || [] )
    @renderQuestions()

  postReview:=>
    console.log "posting"

module.exports = QuestionController
