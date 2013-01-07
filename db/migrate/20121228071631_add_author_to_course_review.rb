class AddAuthorToCourseReview < ActiveRecord::Migration
  def change
  	add_column :course_reviews, :author, :string
  end
end
