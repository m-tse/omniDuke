class DropUnneededColumnsFromReviews < ActiveRecord::Migration
  def up
  	remove_column :course_reviews, :assignment_easiness
  	remove_column :course_reviews, :test_easiness
  	remove_column :course_reviews, :helpfulness
  	remove_column :course_reviews, :clarity
  	remove_column :course_reviews, :enthusiasm
  	remove_column :course_reviews, :course_content
  	remove_column :course_reviews, :fairness
  	remove_column :course_reviews, :textbook_usefulness
  	add_column :course_reviews, :overall_quality, :integer
  	add_column :course_reviews, :overall_difficulty, :integer

  	add_column :instructor_reviews, :enthusiasm, :integer
  	add_column :instructor_reviews, :helpfulness, :integer
  	add_column :instructor_reviews, :accessibility, :integer
  	add_column :instructor_reviews, :clarity, :integer
  	add_column :instructor_reviews, :fairness, :integer
  end

  def down
  end
end
