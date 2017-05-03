require 'spec_helper'

describe(City) do
  describe '#name' do
    it('gives the name of the city') do
      test_city = City.new({:name => "Toronto"})
      expect(test_city.name()).to eq("Toronto")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_city = City.new({:name => "Toronto"})
      test_city.save()
      expect(test_city.id()).to be_an_instance_of(Fixnum)
      expect(City.all()).to eq([test_city])
    end
  end

  describe '#==' do
    it('is true if cities have same name') do
      city1 = City.new({:name => "Toronto"})
      city2 = City.new({:name => "Toronto"})
      expect(city1).to eq(city2)
    end
  end

  describe '#update_city' do
    it "lets you update a city" do
      city = City.new({:name => "Seattle"})
      city.save()
      city.update_city("Portland")
      city = City.find(city.id())
      expect(city.name()).to(eq("Portland"))
    end
  end

  describe '#delete' do
    it "deletes a city from the cities database" do
      city = City.new({:name => "Seattle"})
      city.save()
      city.delete()
      expect(City.all()).to eq([])
    end
    it "deletes a city from the stops database" do
      city = City.new({:name => "Seattle"})
      city.save()
      train = Train.new({:name => "polar express"})
      train.save()
      city.update_stops([train.id()])
      stop = Helper.all_stops().first()
      expect(stop["city_id"].to_i()).to eq(city.id())
      city.delete()
      expect(Helper.all_stops().first()).to eq(nil)
    end
  end
end
