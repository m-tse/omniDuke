class Course < ActiveRecord::Base
  attr_accessible :course_description, :name, :semester
  has_many :teacher

end
