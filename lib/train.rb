class Train
  attr_accessor(:name)
  attr_reader(:id)

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def ==(another_train)
    return self.name() == another_train.name()
  end

  def cities
    list_cities = []
    stops = DB.exec("SELECT * FROM stops WHERE train_id = #{self.id};")
    stops.each() do |stop|
      id = stop['city_id'].to_i()

      name = City.find(id).name()
      list_cities.push(City.new({:name => name, :id => id}))
    end
    return list_cities
  end

  def not_cities
    not_cities = []
    all_cities = City.all()
    cities = self.cities()
    all_cities.each() do |city|
      if not cities.include?(city)
        not_cities.push(city)
      end
    end
    return not_cities
  end

  def update_train(name)
    DB.exec("UPDATE trains SET name = '#{name}' WHERE id = #{self.id()};")
  end

  def update_stops (city_ids)
    # stop_day = attributes[:stop_day]
    # stop_time = attributes[:stop_time]
    city_ids.each() do |city_id|
      DB.exec("INSERT INTO stops(train_id, city_id) VALUES (#{self.id()}, #{city_id.to_i})")
    end
  end

  def delete_train
    self.delete_stops()
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end

  def delete_stops
    DB.exec("DELETE FROM stops WHERE train_id = #{self.id()};")
  end

  class << self
    def all
      all_trains = DB.exec('SELECT * FROM trains ORDER BY name;')
      saved_trains = []
      all_trains.each() do |train|
        name = train['name']
        id = train['id'].to_i()
        each_train = Train.new({:name => name, :id => id})
        saved_trains.push(each_train)
      end
      return saved_trains
    end

    def find(id)
      found_train = nil
      Train.all().each() do |train|
        if train.id() == id
          found_train = train
        end
      end
      return found_train
    end
  end
end
