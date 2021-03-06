class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
      self.name = student_hash[:name]
      self.location = student_hash[:location]
      @@all << self

  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      student = Student.new(student_hash)
      self.all << student
    end

  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send(("#{key}="), value)
    end

  end

  def self.all
    @@all
  end
end

