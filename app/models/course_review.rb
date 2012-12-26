class CourseReview < ActiveRecord::Base
#  attr_accessible :
  belongs_to :course_meta
  validates :course_meta_id, presence:true
  after_save{
  	self.course_meta.save
  }
end
