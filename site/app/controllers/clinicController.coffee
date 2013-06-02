Clinic = require('models/Clinic')

class ClinicController extends Spine.Controller
  className: "clinicController"

  events:
    'click .placeholder' : "showAddComment"
    'click .star' : "setRaiting"
    'click .commentAdder .button': "sendComment"

  elements:
    ".placeholder" : "placeholder"
    ".commentAdder" : "commentAdder"

    "#map" : "mapDiv"
    ".content" : "content"


  constructor: ->
    super
    @render()
    Clinic.fetch =>
      @renderList()
      setTimeout =>
        for clinic in Clinic.all()
          @addToMap clinic
      , 1000

  sendComment:=>
    review = 
      clinic: @current_clinic.name 
      raiting: $(".star.active").length
      comment: $(".commentAdder textarea").val()


    console.log "review is ", JSON.stringify(review)

    $.get "/addReview" , {review:JSON.stringify(review)}

    @commentAdded = true
    @current_clinic.reviews.reviews.push({score: review.raiting, comment: review.comment })
    @renderClinic()

  setRaiting:(e)=>
    @rating = $(e.currentTarget).data().raiting
    $(".star").removeClass("active")
    for i in [0...(@rating+1)]
      $(".star:nth-child(#{i})").addClass("active")

  active:(params)->
    super 
    @map?.invalidateSize()
    
    if params.slug?
      @current_clinic = Clinic.findBySlug(params.slug)
      if @current_clinic?
        @renderClinic()
      else 
        @renderList()
    else 
      @renderList()

  showAddComment:=>
    @placeholder.hide()
    @commentAdder.show()

  goToMarker:(clinic)=>
    if @markers?
      marker = @map.panTo @markers[clinic.slug()].getLatLng()
      @map.setZoom(13)
  addToMap:(clinic)=>
    @markers ||= []
    @markers[clinic.slug()] = L.marker([clinic.loc.lat, clinic.loc.lng]).addTo(@map);

  renderList:=>
    @content.html require('views/clinicsList')
      clinics : Clinic.all()
    @delegateEvents(@events)
    @refreshElements()

  renderClinic:=>
    @content.html require('views/clinicsShow')
      clinic : @current_clinic
    
    @goToMarker @current_clinic

    @delegateEvents(@events)
    @refreshElements()

  render:=>
    @html require('views/clinics') 
      clinics: Clinic.all()
    @delay @renderMap, 200

  renderMap:=>
    @map = L.map 'map', 
      center: [41.84501267270692, -87.5225830078125]
      zoom: 9
    window.map = @map
    L.Icon.Default.imagePath = '/images/'

    @tiles = L.tileLayer 'http://{s}.tile.osm.org/{z}/{x}/{y}.png', 
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    @tiles.addTo(@map)



module.exports = ClinicController
