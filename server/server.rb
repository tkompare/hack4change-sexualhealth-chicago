require 'sinatra'
require 'mongo'
require 'json'

connection = Mongo::MongoClient.new 'localhost', 27017
Client = connection["sexual-health"]

set :public_folder, 'public'

get "/" do
  redirect '/index.html'
end

get '/getReviews' do 
	content_type :json

	clinics = Client['clinics'].find().collect{|c| c}
	clinics.to_json
end

post '/addReview' do 
	clinic = params[:clinic]
	name = clinic.name
	review = params[:review]
	
	unless Client["clinics"].find({name:name}).length == 0  
		Client["client"].create(clinic)
	end

	Clients['clinics'].update({name: name},{"$push" =>{'reviews' => review }})
end
	