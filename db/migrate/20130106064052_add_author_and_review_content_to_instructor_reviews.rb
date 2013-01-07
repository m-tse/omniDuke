class AddAuthorAndReviewContentToInstructorReviews < ActiveRecord::Migration
  def change
  	add_column :instructor_reviews, :author, :string
  	add_column :instructor_reviews, :review_content, :text
  end
end
