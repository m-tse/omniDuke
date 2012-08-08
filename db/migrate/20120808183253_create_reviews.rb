class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :assignment_easiness
      t.integer :test_easiness
      t.integer :helpfulness
      t.integer :clarity
      t.integer :enthusiasm
      t.integer :course_content
      t.integer :textbook_usefulness
      t.text :review_content

      t.timestamps
    end
  end
end
