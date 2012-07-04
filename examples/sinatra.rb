$:.push File.dirname(__FILE__) + '/../lib'

require 'omniauth-amember_pro'
require 'sinatra'

use Rack::Session::Cookie
use OmniAuth::Builder do
   provider :amember_pro, :auth_url => "http://www.example.org/amember/", :api_key => "XXXXXXXXXXXXXXXX"
 end

get '/' do
  "<a href='/auth/amember_pro'>Log in with AMember</a>"
end

post '/auth/amember_pro/callback' do
  content_type 'text/plain'
  request.env['omniauth.auth'].inspect
end

get '/auth/failure' do
  if params['message'] == "invalid_credentials"
    "Wrong username and password!"
  else
    "Unknown failure"
  end
end

