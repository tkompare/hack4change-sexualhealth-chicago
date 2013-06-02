require 'sinatra'
require 'mongo'
require 'json'
require 'pry'
require 'rest-client'

connection = Mongo::MongoClient.new 'localhost', 27017
Client = connection["sexual-health"]

set :public_folder, 'site/public'

get "/" do
  send_file 'site/public/index.html'
end

def find_reviews(details)
	slugged_name = details["site_name"].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
	Client["reviews"].find({name: slugged_name}).first
end

get '/getClinics' do 
	content_type :json
	clinics = JSON.parse(RestClient.get('https://data.cityofchicago.org/resource/ajzs-akmm.json'))
	
	clinics_with_reviews = clinics.collect do |c|
		reviews = find_reviews c 
		reviews ||= {total_score: 0, reviews:[]}
		c["reviews"] = reviews
	end

	clinics.to_json
end

get '/addReview' do
	clinic = params[:clinic_name]
	review = params[:review]
	unless Client["clinics"].find({name:name}).length == 0  
		Client["client"].create(clinic)
	end

	Clients['clinics'].update({name: name},{"$push" =>{'reviews' => review }})
end
	