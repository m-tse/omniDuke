class CourseMeta < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :courses
  has_many :course_reviews
end
