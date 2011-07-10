require 'sinatra'

get '/' do
  "hello guys"
end

get '/routes' do
  "routes are evaluated from the top"
end

post '/say/:word' do |word|
  "say #{word}"
end

get '/say/*/to/*' do |what,whom|
  "#{whom}, #{what}!!"
end

