class City
  attr_accessor(:name)
  attr_reader(:id)

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def self.all
    all_cities = DB.exec('SELECT * FROM cities ORDER BY name;')
    saved_cities = []
    all_cities.each() do |city|
      name = city['name']
      id = city['id'].to_i()
      each_city = City.new({:name => name, :id => id})
      saved_cities.push(each_city)
    end
    return saved_cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def ==(another_city)
    return self.name() == another_city.name()
  end

  def self.find(id)
    found_city = nil
    City.all().each() do |city|
      if city.id() == id
        found_city = city
      end
    end
    return found_city
  end
  # 
  # def update_city(name)
  #   DB.exec("UPDATE cities SET name = '#{name}' WHERE id = #{self.id()};")
  # end

  def trains
    list_trains = []
    stops = DB.exec("SELECT * FROM stops WHERE city_id = #{self.id};")
    stops.each() do |stop|
      id = stop['train_id'].to_i()

      name = Train.find(id).name()
      list_trains.push(Train.new({:name => name, :id => id}))
    end
    return list_trains
  end

  def update_stops (train_ids)
    train_ids.each() do |train_id|
      DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{train_id}, #{self.id()})")
    end
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
    DB.exec("DELETE FROM stops WHERE city_id = #{self.id()};")
  end
end
