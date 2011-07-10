require 'sinatra'

get '/' do
  "hello guys"
end

get '/routes' do
  ["routes are evaluated from the top"]
end

post '/say/:word' do |word|
  [200, "say #{word}"]
end

get '/say/*/to/*' do |what,whom|
  [404, "#{whom}, #{what}!!"]
end

get '/redirect/:where' do |where|
  redirect to('http://'+where)
end

get '/hello' do
  redirect to('/bye')
end

get '/bye' do
  body {"bye"}
end
