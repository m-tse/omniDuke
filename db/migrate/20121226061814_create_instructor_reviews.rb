class CreateInstructorReviews < ActiveRecord::Migration
  def change
    create_table :instructor_reviews do |t|
    	t.integer :overall_quality
    	t.integer :helpfulness
    	t.integer :accessbility
    	t.integer :clarity
    	t.integer :fairness
    	t.integer :instructor_id
      t.timestamps
    end
  end
end
