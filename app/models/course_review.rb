class CourseReview < ActiveRecord::Base
  attr_accessible :usefulness, :stimulating, :content_quality, :homework_difficulty, 
  :lab_difficulty, :midterm_difficulty, :final_difficulty, :course_meta_id, :out_of_class_work_hours
  belongs_to :course_meta
  validates :course_meta_id, presence:true
  after_save{
  	self.course_meta.save
  }
end
