# encoding: utf-8
require 'sinatra'
require 'sqlite3'
require 'pp'



db = SQLite3::Database.new "db/post.db"
db.results_as_hash = true


get '/' do
  posts = db.execute("SELECT * FROM posts ORDER BY id DESC")
  # pp posts
  # erb :index
  erb :index,{ :locals => { :posts => posts} }
end

get '/hello' do
  "Hello world"
end

get '/example' do
  erb :example
end

post '/' do

# p params["ex_text"]

stmt = db.prepare("INSERT INTO posts (text) VALUES (?)")
  stmt.bind_params(params["ex_text"])
  stmt.execute
  redirect '/'
end
