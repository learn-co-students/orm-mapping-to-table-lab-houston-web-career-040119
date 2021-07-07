require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, some_id = nil)
    @name = name
    @grade = grade
    @id = some_id
  end

  def self.create_table
    DB[:conn].execute('CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)')
  end

  def self.drop_table
    DB[:conn].execute('DROP TABLE students')
  end

  def save
    DB[:conn].execute('INSERT INTO students(name, grade) VALUES(?,?)',self.name, self.grade)
    @id = DB[:conn].execute('SELECT last_insert_rowid() FROM students')[0][0]
    self
  end

  def self.create(name: name, grade: grade)
    new_student = Student.new(name, grade)
    new_student = new_student.save
    
  end
end
