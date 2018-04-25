require 'sinatra/base'
require 'levenshtein'
require 'haml'
require 'sass'
require 'rest-client'
require 'json'
require 'pry'

class LandingPage < Sinatra::Base
	get '/' do
		@data = JSON[open('data.json').read]
		haml :index, :format => :html5
	end

	post '/request-access' do
		@email = params["email"]
		if params[:email] && !File.open("list.txt").read.split(",").include?(@email) 
			File.open("list.txt", "a") do |f|
				f << "#{@email},"
			end
			redirect '/thank-you'
		else
			@data = JSON[open('data.json').read]
			@error = "You are already on the list."
			haml :index
		end
	end

	get '/thank-you' do
		@data = JSON[open('data.json').read]
		haml :thankyou
	end

	get '/index.css' do
  		scss :index
	end
end