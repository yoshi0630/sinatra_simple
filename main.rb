require 'sinatra'

get '/' do
  erb :index
end

get '/hello' do
  "Hello world"
end

get '/example' do
  erb :example
end

post '/' do

p params["ex_text"]

end
