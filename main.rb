require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get '/' do
  erb :home
end

get '/home' do
  erb :home
end

get '/new' do
  erb :new
end

get '/friends' do
  sql = "select * from friends"
  @rows = run_sql(sql)
  erb :friends
end

post '/create' do
  name = params[:name]
  age = params[:age]
  gender = params[:gender]
  image = params[:image]
  twitter = params[:twitter]
  github = params[:github]

  sql = "insert into friends (name, age, gender, image, twitter, github) values ('#{name}', '#{age}','#{gender}', '#{image}','#{twitter}', '#{github}')"
  run_sql(sql)
  redirect to('/friends')
end

def run_sql(sql)
  conn = PG.connect(:dbname =>'friends_app', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end