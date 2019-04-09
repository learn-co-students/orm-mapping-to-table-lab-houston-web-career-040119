require 'pry'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader  :id


  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    #creates the students table in the database
    DB[:conn].execute('CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)')
  end

  def self.drop_table
    #drops the students table from the database
    DB[:conn].execute('DROP TABLE students')
  end

  def save
    # saves the student class to the database
    DB[:conn].execute('INSERT INTO students (name, grade) VALUES (?,?)',self.name, self.grade)
    @id = DB[:conn].execute('SELECT id FROM students WHERE name = ? AND grade = ?',self.name, self.grade).flatten[0]
  end

  def self.create(hash)
    #takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses
    #the #save method to save that student to the database
    #returns the new object that it instantiated
    new_student = Student.new(hash[:name],hash[:grade])
    new_student.save
    new_student 
  end

end
