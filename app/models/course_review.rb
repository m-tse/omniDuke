class CourseReview < ActiveRecord::Base
  attr_accessible :assignment_easiness, :clarity, :course_content, :enthusiasm, :helpfulness, :review_content, :test_easiness, :textbook_usefulness
  belongs_to :course_meta

end
