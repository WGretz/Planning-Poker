require 'sequel'
DB = Sequel.sqlite


class Room < Sequel::Model
  
  db= DB
  
  def self.make_table
    return if DB.table_exists? :rooms 
    DB.create_table :rooms do
      primary_key :id
      String :name
      String :subject
    end
  end
  
  def self.find_or_create(name)
    #if rooms.where(:name => name).first
       self.insert(:name => name)
    # end
    return self.where(:name => name).first
  end
    
  def name
   self[:name]
  end
  
  make_table
end