class AddContentQualityToCourseReviews < ActiveRecord::Migration
  def change
  	add_column :course_reviews, :content_quality, :integer
  end
end
