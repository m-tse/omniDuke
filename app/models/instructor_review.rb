class InstructorReview < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :instructor
end
