class Subject < ActiveRecord::Base
  attr_accessible :abbr, :name
  validates :abbr, :name, :presence => true
#  has_and_belongs_to_many :courses
  has_many :course_numberings
  has_many :courses, :through => :course_numberings
end
