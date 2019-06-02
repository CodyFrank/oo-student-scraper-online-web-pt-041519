class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @@all << student_hash.each{|key, value| self.send(("#{key}="), value)}
  end

  def self.create_from_collection(students_array)
    students_array.each do |info|
      student = self.new(info)
    end
    student
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
