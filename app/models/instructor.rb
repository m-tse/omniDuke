class Instructor < ActiveRecord::Base
  attr_accessible :name
  has_many :course_instructor_relations
  has_many :courses, :through => :course_instructor_relations
  validates :name, :presence => true
end
