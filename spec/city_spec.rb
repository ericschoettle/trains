require 'spec_helper'

describe(City) do
  describe '#name' do
    it('gives the name of the city') do
      test_city = City.new({:name => "Toronto", :train_id => 1})
      expect(test_city.name()).to eq("Toronto")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_city = City.new({:name => "Toronto", :train_id => 1})
      test_city.save()
      expect(test_city.id()).to be_an_instance_of(Fixnum)
      expect(City.all()).to eq([test_city])
    end
  end

  describe '#==' do
    it('is true if cities have same name') do
      city1 = City.new({:name => "Toronto", :train_id => 1})
      city2 = City.new({:name => "Toronto", :train_id => 1})
      expect(city1).to eq(city2)
    end
  end

  describe '#update' do
    it "lets you update a city" do
      city = City.new({:name => "Seattle", :train_id => 1})
      city.save()
      city.update({:name => "Portland", :train_id => 1})
      expect(city.name()).to(eq("Portland"))
    end
  end
end
