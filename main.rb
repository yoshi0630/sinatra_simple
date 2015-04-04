# encoding: utf-8
require 'sinatra'
require 'sqlite3'
# require 'pp'
require 'securerandom'


db = SQLite3::Database.new "db/post.db"
db.results_as_hash = true


get '/' do
  posts = db.execute("SELECT * FROM posts ORDER BY id DESC")
  # pp posts
  # erb :index
  erb :index,{ :locals => { :posts => posts} }
end

get '/hello' 
  "Hello world"
end

get '/example' do
  erb :example
end

post '/' do

# p params["ex_text"]

# stmt = db.prepare("INSERT INTO posts (text) VALUES (?)")
  # stmt.bind_params(params["ex_text"])
file_name = ""

if params["file"]
ext = ""
if params["file"][:type].include? "jpeg"
ext = "jpg"
elsif params["file"][:type].include? "png"
ext = "png"
else
return "投稿できる画像形式はjpgとpngだけです"
end

# 適当なファイル名を付ける
file_name = SecureRandom.hex + "." + ext

# 画像を保存
File.open("./public/uploads/" + file_name, 'wb') do |f|
f.write params["file"][:tempfile].read
end

stmt = db.preapare("INSERT INTO posts (text, img_file_name VALUES (?, ?")
stmt.bind_params(params["ex_text"], file_name)
  stmt.execute
  redirect '/'
end
