class MakeOverallQualityIntoFloat < ActiveRecord::Migration
  def up
  	remove_column :course_meta, :overall_quality
  	add_column :course_meta, :overall_quality, :decimal

  	remove_column :course_meta, :overall_difficulty
  	add_column :course_meta, :overall_difficulty, :decimal

  	remove_column :instructors, :overall_quality
  	add_column :instructors, :overall_quality, :decimal
  end

  def down
  end
end
