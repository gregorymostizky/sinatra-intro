require 'sinatra/base'

require 'json'
require 'csv'

class Monitor < Sinatra::Base

  enable :sessions # cookie based only, more advanced by rack

  set :public, File.dirname(__FILE__) + '/public'
  set :static, File.dirname(__FILE__) + '/public'

  def initialize
    super

    @servers = Servers.new
  end

  before do
    session[:counter] ||= 0
    session[:counter] += 1
  end


  get '/all.csv' do
    attachment 'all.csv'
    CSV.generate do |csv|
      csv << ['Server', 'Time', 'Status']
      @servers.each do |server, statuses|
        statuses.each do |ts, status|
          csv << [server, ts, status]
        end
      end
    end
  end

  get '/' do
    @seen = session[:counter]
    erb :welcome
  end

  post '/report/:server/:status' do |server, status|
    @servers[server] ||= []
    @servers[server] << [Time.now, status]

    body { "ok" }
  end

  get %r{/server/(\w+)\.json} do |server|
    @server = server
    @statuses = @servers[server]

    content_type 'application/json'
    body { {:server => @server, :statuses => @statuses}.to_json }
  end

  get %r{/server/(\w+)} do |server|
    @server = server
    @statuses = @servers[server]
    erb :server
  end


# last rule to catch all
  get '/*' do
    redirect to('/')
  end

end
