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
      test_train = Train.new({:name => "polar express"})
      test_train.save()
      test_city = City.new({:name => "Toroto", :train_id => test_train.id()})
      test_city.save()
      test_city1 = City.new({:name => "Omaha", :train_id => test_train.id()})
      test_city1.save()
      expect(test_train.cities()).to eq([test_city, test_city1])
    end

    describe '#update_train' do
      it "lets you update trains in the database" do
        train = Train.new({:name => "polar express"})
        train.save()
        train.update_train({:name => "thomas"})
        expect(train.name()).to(eq("thomas"))
      end
    end

    describe '#delete' do
      it "lets you delete a train" do
        train = Train.new({:name => "polar express"})
        train.save()
        train.delete()
        expect(Train.all()).to eq([])
      end
    end

    describe '#update_stops' do
      it "creates join rows to connect cities and a train" do
        train = Train.new({:name => "polar express"})
        train.save()
        city = City.new({:name => "Toroto", :train_id => 1})
        city.save()
        city1 = City.new({:name => "Omaha", :train_id => 1})
        city1.save()
        train.update_stops([city1.id(), city.id()])
      end
    end
  end
end
