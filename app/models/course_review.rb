class CourseReview < ActiveRecord::Base
  attr_accessible :usefulness, :stimulating, :content_quality, :homework_difficulty, 
  :lab_difficulty, :midterm_difficulty, :final_difficulty, :course_meta_id, :out_of_class_work_hours,
  :review_content

  validates :usefulness, :stimulating, :content_quality, :homework_difficulty, 
  :lab_difficulty, :midterm_difficulty, :final_difficulty, :out_of_class_work_hours,
   :inclusion => {:in => [nil,0,1,2,3,4,5,6,7,8,9,10]}

  belongs_to :course_meta
  validates :course_meta_id, presence:true
  after_save{
  	self.course_meta.save
  }
end
