class Course < ActiveRecord::Base
  attr_accessible :course_description, :name, :semester
  has_one :teacher

end
