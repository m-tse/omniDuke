class CourseReview < ActiveRecord::Base
#  attr_accessible :
  belongs_to :course_meta
  validates :course_meta_id, presence:true
  after_save{
  	meta = self.course_meta
  	meta.save
  }
end
