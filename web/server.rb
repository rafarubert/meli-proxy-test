require 'sinatra/base'

require_relative '../lib/meli_proxy'

class Server < Sinatra::Base
  TARGET_URL = "https://api.mercadolibre.com/"

  before do
    content_type 'application/json'

    #request.request_method == "POST"
    #request.base_url
    #params
    #request.ip
    #request.path_info
    #query_string
    #binding.pry
    #redirect "https://api.mercadolibre.com/", 303
    #Log.create()
  end

  after do

    #redirect TARGET_URL, 303
    redirect "/error", 303 if request.path_info != "/error"
  end

  get '/error' do
    {'error': 'Invalid params'}.to_json
  end
end