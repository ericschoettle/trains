require 'spec_helper'

describe(Train) do
  describe '#name' do
    it('gives the name of the train') do
      test_train = Train.new({:name => "polar express"})
      expect(test_train.name()).to eq("polar express")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_train = Train.new({:name => "polar express"})
      test_train.save()
      expect(test_train.id()).to be_an_instance_of(Fixnum)
      expect(Train.all()).to eq([test_train])
    end
  end

  describe '#==' do
    it('is true if trains have same name') do
      train1 = Train.new({:name => "polar express"})
      train2 = Train.new({:name => "polar express"})
      expect(train1).to eq(train2)
    end
  end

  describe '#==' do
    it('is true if trains have same name') do
      train1 = Train.new({:name => "polar express"})
      train2 = Train.new({:name => "polar express"})
      expect(train1).to eq(train2)
    end
  end

  describe '.find' do
    it('returns a train by its ID') do
      train1 = Train.new({:name => "polar express"})
      train1.save()
      train2 = Train.new({:name => "train2"})
      train2.save()
      expect(Train.find(train2.id())).to eq(train2)
    end
  end

  describe '#cities' do
    it('returns an array of cities for that train') do
      train = Train.new({:name => "polar express"})
      train.save()
      city = City.new({:name => "Toronto"})
      city.save()
      city1 = City.new({:name => "Omaha"})
      city1.save()
      train.update_stops ([city.id, city1.id])
      expect(train.cities()).to eq([city, city1])
    end
  end
  describe '#update_train' do
    it "lets you update trains in the database" do
      train = Train.new({:name => "polar express"})
      train.save()
      train.update_train("thomas")
      train = Train.find(train.id())
      expect(train.name()).to(eq("thomas"))
    end
  end

  describe '#delete' do
    it "deletes a train from trains database" do
      train = Train.new({:name => "polar express"})
      train.save()
      train.delete()
      expect(Train.all()).to eq([])
    end
    it "deletes a train from stops database" do
      train = Train.new({:name => "polar express"})
      train.save()
      city = City.new({:name => "Seattle"})
      city.save()
      train.update_stops([city.id()])
      stop = Helper.all_stops().first()
      expect(stop["train_id"].to_i()).to eq(train.id())
      train.delete()
      expect(Helper.all_stops().first()).to eq(nil)
    end
  end

  describe '#update_stops' do
    it "creates join rows to connect cities and a train" do
      train = Train.new({:name => "polar express"})
      train.save()
      city = City.new({:name => "Toronto"})
      city.save()
      city1 = City.new({:name => "Omaha"})
      city1.save()
      train.update_stops([city1.id(), city.id()])
      expect(train.cities()).to eq([city1, city])
    end
  end

  describe '#not_cities' do
    it "shows cities that are not assigned to the train" do
      train = Train.new({:name => "polar express"})
      train.save()
      city = City.new({:name => "Toronto"})
      city.save()
      city1 = City.new({:name => "Omaha"})
      city1.save()
      train.update_stops([city1.id()])
      expect(train.not_cities()).to eq([city])
    end
  end
end
