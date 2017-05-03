
class Helper
  def self.clear_db
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM trains *;")
  end

  def self.all_stops
    DB.exec("SELECT * FROM stops;")
  end
end
