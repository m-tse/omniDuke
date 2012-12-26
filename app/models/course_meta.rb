class CourseMeta < ActiveRecord::Base
  attr_accessible :course_name
  validates :course_name,  :presence => true
  has_many :courses
  has_many :course_reviews
end
