class CourseInstructorRelation < ActiveRecord::Base
   attr_accessible :instructor_status
  belongs_to :instructor
  belongs_to :course
end
