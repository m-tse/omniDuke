class CourseReview < ActiveRecord::Base
#  attr_accessible :
  belongs_to :course_meta
  after_save{
  	meta = self.course_meta
  	meta.save
  }
end
