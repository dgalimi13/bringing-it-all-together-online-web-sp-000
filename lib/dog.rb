class Dog 
  attr_accessor :id, :name, :breed 
  
  def initialize(id:nil,name:,breed:)
    @id = id 
    @name = name 
    @breed = breed 
  end 
  
  def self.create_table
    sql =  <<-SQL 
    CREATE TABLE IF NOT EXISTS dogs (
    id INTEGER PRIMARY KEY, 
    name TEXT, 
    breed TEXT
     )
    SQL
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table
    sql =  <<-SQL
    DROP TABLE dogs
      SQL
      DB[:conn].execute(sql) 
  end 
  
  def save 
    if self.id
    self.update
  else
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
  end 
  end 
  
  def self.create(name:,breed:)
    dog = Dog.new(name: name,breed: breed)
    dog.save
    dog
  end
  
  def self.new_from_db
    
  end 
  
  def update 
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end 
end