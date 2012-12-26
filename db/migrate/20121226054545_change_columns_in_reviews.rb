class ChangeColumnsInReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :final_difficulty, :integer
  	add_column :reviews, :lab_difficulty, :integer
  	add_column :reviews, :midterm_difficulty, :integer
  	add_column :reviews, :homework_difficulty, :integer
  	add_column :reviews, :out_of_class_work_hours, :integer
  	add_column :reviews, :stimulating, :integer
  	add_column :reviews, :fairness, :integer
  	add_column :reviews, :usefulness, :integer
  	rename_table :reviews, :course_reviews

  	create_table :instructor_reviews


  end
end
