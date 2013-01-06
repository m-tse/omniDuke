class InstructorReview < ActiveRecord::Base
  attr_accessible :author, :review_content, :helpfulness, :accessibility, :clarity, :fairness, :instructor_id
  belongs_to :instructor

  validates :instructor_id, presence:true
  after_save{
  	self.instructor.save
  }
end
