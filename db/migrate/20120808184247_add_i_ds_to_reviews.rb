class AddIDsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :course_id, :integer
    add_column :reviews, :instructor_id, :integer
  end
end
