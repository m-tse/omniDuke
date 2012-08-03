class Course < ActiveRecord::Base
  attr_accessible :description, :name, :credits, :location
  has_many :prerequisite_relations, :foreign_key => "course_id", :class_name=>"PrerequisiteRelation"
  has_many :prerequisites, :through => :prerequisite_relations
  belongs_to :advanced_course, :class_name => "Course"

  has_many :roles
  has_many :instructors, :through => :roles

  has_and_belongs_to_many :modes_of_inquiry
  has_and_belongs_to_many :areas_of_knowledge

  belongs_to :session, :inverse_of => :courses

  has_many :course_numberings
  has_many :subjects, :through => :course_numberings
end
