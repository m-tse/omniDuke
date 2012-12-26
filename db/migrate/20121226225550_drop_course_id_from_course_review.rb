class DropCourseIdFromCourseReview < ActiveRecord::Migration
  def up
  	remove_column :course_reviews, :course_id
  end

  def down
  end
end
