class AddOverallQualityToCourseMeta < ActiveRecord::Migration
  def up
  	add_column :course_meta, :overall_quality, :integer
  	add_column :course_meta, :overall_difficulty, :integer
  	remove_column :course_reviews, :overall_quality
  	remove_column :course_reviews, :overall_difficulty

  	add_column :instructors, :overall_quality, :integer
  	remove_column :instructor_reviews, :overall_quality
  end
  def down
  end
end
