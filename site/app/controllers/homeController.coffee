class HomeController extends Spine.Controller
  className: "homeController"

  events:
    'submit form' : 'collectInfo'

  constructor: ->
    super
    @log "Well, hello there."
    @render()

  render:=>
    @html require('views/info')()

  collectInfo:(e)=>
    e.preventDefault()
    @navigate("/questions")

module.exports = HomeController
