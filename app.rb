require 'sinatra'
require 'sinatra/reloader'
require './lib/train'
require './lib/city'
require './lib/helper'
require 'pry'
require 'pg'
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "trains"})

get('/') do
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end


post('/train') do
  name = params[:name]
  new_train = Train.new({:name => name})
  new_train.save()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

post('/city') do
  name = params[:name]
  train_id = params[:train].to_i()
  new_city = City.new({:name => name, :train_id => train_id})
  new_city.save()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

get('/train/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
end

post('/clear') do
  Helper.clear_db()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

patch("/train/:id") do
  name = params["name"]
  @train = Train.find(params["id"].to_i())
  @train.update({:name => name})
  erb(:train)
end

delete("/train/:id") do
  train = Train.find(params["id"].to_i())
  train.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end
get("/city/:id") do
  @city = City.find(params["id"].to_i())
  erb(:city)
end
patch("/city/:id") do
  name = params["name"]
  @city = City.find(params["id"].to_i())
  @city.update({:name => name})
  erb(:city)
end

delete("/city/:id") do
  city = City.find(params["id"].to_i())
  city.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end