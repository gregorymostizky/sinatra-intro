require 'sinatra'

enable :sessions # cookie based only, more advanced by rack

configure do
  $servers = {}
end

before  do
  session[:counter] ||= 0
  session[:counter] += 1

  @servers = $servers
end

get '/' do
  @seen = session[:counter]
  erb :welcome
end

post '/report/:server/:status' do |server,status|
  @servers[server] ||= []
  @servers[server] << [Time.now, status]

  body {"ok"}
end


# last rule to catch all
get '/*' do
  redirect to('/')
end