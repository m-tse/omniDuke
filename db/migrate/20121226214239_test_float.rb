class TestFloat < ActiveRecord::Migration
  def up
  	remove_column :course_meta, :overall_quality
  	remove_column :course_meta, :overall_difficulty
  	add_column :course_meta, :overall_quality, :float
  	add_column :course_meta, :overall_difficulty, :float 
  	remove_column :instructors, :overall_quality
  	add_column :instructors, :overall_quality, :float
  end
  def down
  end

end
