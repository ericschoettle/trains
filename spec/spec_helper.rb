require './lib/train'
require './lib/city'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => "trains_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM trains *;")
  end
end
