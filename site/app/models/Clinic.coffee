class Clinic extends Spine.Model
  @configure 'Clinic', 'name', 'address','loc', 'openhours', 'phoneno', 'details', 'reviews'


  slug: =>
    @name.toLowerCase().replace( `/ /g`, '-' ).replace(/[^\w-]+/g,'')

  addressString:=>
    [@address.street, @address.cty, @address.state, @address.zip].join(",")

  averageScore:=>
    if @reviews.reviews.length == 0
      result = 0 
    else
      result = Math.floor(@reviews.total_score*1.0 / @reviews.reviews.length*1.0)
    result
     
  @findBySlug:(slug)->
    result = @select (a)=>
      a.slug() == slug 
    result[0]

  @fetch : (cb)-> 
    $.getJSON '/getClinics', (clinicData)=>
      console.log "tick ", clinicData
      for data in clinicData
        Clinic.create
          name: data.site_name
          address : {street: data.address, city: data.city, state: data.state, zip: data.zip}
          openhours : data.hours_of_operation
          loc : {lat: data.location.latitude, lng : data.location.longitude}
          phoneno : data.phone
          reviews : data.reviews
      cb() if cb?

module.exports = Clinic