require File.expand_path('../app.rb', __FILE__)
require 'rack/ssl'
use Rack::ShowExceptions

if ENV['RACK_ENV'] == 'production'
   use Rack::SSL
end

run LandingPage.new