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

end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/newpost' do
erb :newpost
end

post '/newpost' do

@text=params[:text]
erb "Nothing better then good post. \n #{@text}"
end

get '/posts' do
erb :posts
end