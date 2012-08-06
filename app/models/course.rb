class Course < ActiveRecord::Base
  attr_accessible :description, :name, :credits, :location
  validates :name, :presence => true
  has_many :prerequisite_relations, :foreign_key => "course_id", :class_name=>"PrerequisiteRelation"
  has_many :prerequisites, :through => :prerequisite_relations
  belongs_to :advanced_course, :class_name => "Course"

  has_many :sections
  has_many :instructors, :through => :sections
#just jizzed at how this ^ worked.. I have courses>sections>instructors_sections_join_table>instructors, and it assumed what to do correctly
 # has_many :time_slots, :through => :sections      
#course shouldn't really have access to time slots without first getting section


  has_and_belongs_to_many :modes_of_inquiry
  has_and_belongs_to_many :areas_of_knowledge

  belongs_to :session, :inverse_of => :courses

  has_many :course_numberings, :inverse_of => :course
  has_many :subjects, :through => :course_numberings
end
