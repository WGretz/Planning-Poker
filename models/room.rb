
class Room
  
  def self.make_table
    return if DB.table_exists? :rooms 
    DB.create_table :rooms do
      primary_key :id
      String :name
      String :subject
    end
  end
  
  def self.find(name)
    rooms = DB[:rooms]
    if room = rooms.where(:name => name).first
      return room
    end
    return rooms.insert(:name => name)
  end
    
  make_table
end