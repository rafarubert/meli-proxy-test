require 'sinatra/base'

require_relative '../lib/meli_proxy'

class Server < Sinatra::Base
  before do
    content_type 'application/json'
  end

  get '/error' do
    status params[:status]
    {'error':  params[:message] }.to_json
  end

  after do
    return if request.path_info == '/error'

    log = LogVo.new(
      ip: request.ip,
      path: request.path_info,
      fullpath: request.fullpath
    )

    begin
      redirect RedirectService.new.call(log), 303
    rescue => e
      redirect "/error?message=#{e.message}&status=#{e.status_code}"
    end
  end
end