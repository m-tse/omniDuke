class InstructorReview < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :instructor

  validates :instructor_id, presence:true
  after_save{
  	self.instructor.save
  }
end
