class AddOverallQualityToCourseReview < ActiveRecord::Migration
  def change
  	add_column :course_reviews, :average_quality, :float
  	add_column :course_reviews, :average_difficulty, :float
  	add_column :instructor_reviews, :average_quality, :float
  end
end
