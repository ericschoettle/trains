class City
  attr_accessor(:name, :train_id)
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
      train_id = city['train_id']
      id = city['id'].to_i()
      each_city = City.new({:name => name, :train_id => train_id, :id => id})
      saved_cities.push(each_city)
    end
    return saved_cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name, train_id) VALUES ('#{@name}', '#{@train_id}') RETURNING id;")
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

  def update(attributes)
    @name = attributes[:name]
    @train_id = attributes[:train_id]
    @id = self.id()
    DB.exec("UPDATE cities SET (name) = ('#{@name}') WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end
end
