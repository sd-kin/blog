require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db 
@db=SQLite3::Database.new 'base.db'
@db.results_as_hash = true
end

before do

init_db

end

configure do
init_db
@db.execute 'CREATE TABLE IF NOT EXISTS "posts" 
(
"id" INTEGER PRIMARY KEY AUTOINCREMENT,
created_date DATE,
content TEXT
)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/newpost' do
erb :newpost
end

post '/newpost' do

@text=params[:text]
	if @text.length <= 0 then @error = 'You post is empty'
		return erb :newpost
	 end
@db.execute 'insert into posts (content, created_date) values(?,datetime())', [@text]
erb "Nothing better then good post. \n #{@text}"
redirect to '/posts'
end

get '/posts' do
@all_posts = @db.execute'SELECT * FROM posts ORDER BY id DESC'
erb :posts
end