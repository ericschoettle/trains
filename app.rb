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
  erb(:index)
end

get('/operator') do
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

post('/clear') do
  Helper.clear_db()
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

get('/train/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
end

post('/train') do
  name = params[:name]
  new_train = Train.new({:name => name})
  new_train.save()
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

patch("/train/:id") do
  @train = Train.find(params["id"].to_i())
  @train.update_stops(params[:city_ids])
  erb(:train)
end

delete("/train/:id") do
  @train = Train.find(params["id"].to_i())
  @train.delete_stops(params["city_ids"])
  erb(:train)
end

delete("/train") do
  train = Train.find(params["id"].to_i())
  train.delete_train()
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

get("/city/:id") do
  @city = City.find(params["id"].to_i())
  erb(:city)
end

post('/city') do
  name = params[:name]
  train_id = params[:train].to_i()
  new_city = City.new({:name => name, :train_id => train_id})
  new_city.save()
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

patch("/city/:id") do
  @city = City.find(params["id"].to_i())
  @city.update_stops(params[:train_ids])
  erb(:city)
end

delete("/city/:id") do
  @city = City.find(params["id"].to_i())
  @city.delete_stops(params["train_ids"])
  erb(:city)
end

delete("/city") do
  city = City.find(params["id"].to_i())
  binding.pry
  city.delete_city()
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end
