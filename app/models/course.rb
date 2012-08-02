class Course < ActiveRecord::Base
  attr_accessible :course_description, :name, :semester
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :modes_of_inquiry
  has_and_belongs_to_many :sessions
  has_and_belongs_to_many :areas_of_knowledge
  has_and_belongs_to_many :subjects
end
