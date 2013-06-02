
clinicController = require('controllers/clinicController')
homeController = require('controllers/homeController')
FactController = require('controllers/factController')
QuestionController = require('controllers/questionController')

User = require('models/User')
Clinic = require('models/Clinic')

class App extends Spine.Stack

  controllers:
    'home'                 : homeController
    'clinics'              : clinicController
    'fact'                 : FactController
    'questions'            : QuestionController

  routes:
    '/' : 'home'
    '/clinics'       : 'clinics'
    '/clinics/:slug' : 'clinics'
    '/fact'          : 'fact'
    '/questions'      : 'questions'
    '/questions/:filter'      : 'questions'

  default: 'home'

  constructor: ->
    super
    Spine.Route.setup()

module.exports = App
