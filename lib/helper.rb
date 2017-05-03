
class Helper
  def self.clear_db
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM trains *;")
  end
end
