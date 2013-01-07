class DropInstructorIdFromCourseReviews < ActiveRecord::Migration
  def up
  	remove_column :course_reviews, :instructor_id
  end

  def down
  end
end
