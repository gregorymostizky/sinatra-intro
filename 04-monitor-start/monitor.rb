require 'sinatra'

enable :sessions # cookie based only, more advanced by rack

before  do
  session[:counter] ||= 0
  session[:counter] += 1
end

get '/' do
  @seen = session[:counter]
  erb :welcome
end

# last rule to catch all
get '/*' do
  redirect to('/')
end