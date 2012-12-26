class DropInstructorReviewsTable < ActiveRecord::Migration
  def up
  	drop_table :instructor_reviews
  	
  end

  def down
  end
end
