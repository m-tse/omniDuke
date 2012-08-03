class Course < ActiveRecord::Base
  attr_accessible :course_description, :name, :semester
  has_many :prerequisite_relations, :foreign_key => "course_id", :class_name=>"PrerequisiteRelation"

  has_many :prerequisites, :through => :prerequisite_relations


  belongs_to :advanced_course, :class_name => "Course"
  has_and_belongs_to_many :instructors
  has_and_belongs_to_many :modes_of_inquiry
  belongs_to :session, :inverse_of => :courses
#error: when associating the session by cs100.session = Session.find_by_name("fall2012"), pointer to cs100 through fall.coures does not get created, but it does get created when I do fall.courses<<cs100
  has_and_belongs_to_many :areas_of_knowledge
  has_and_belongs_to_many :subjects
end
