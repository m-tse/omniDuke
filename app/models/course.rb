class Course < ActiveRecord::Base
  attr_accessible :course_description, :name, :semester
  has_many :prerequisite_relations, :foreign_key => "course_id", :class_name=>"PrerequisiteRelation"

  has_many :prerequisites, :through => :prerequisite_relations


  belongs_to :advanced_course, :class_name => "Course"
  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :modes_of_inquiry
  has_and_belongs_to_many :sessions
  has_and_belongs_to_many :areas_of_knowledge
  has_and_belongs_to_many :subjects
end
