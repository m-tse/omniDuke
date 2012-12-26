class AddPrimaryKeysToBelongsTo < ActiveRecord::Migration
  def change
  	add_column :courses, :course_meta_id, :integer
  	add_column :course_reviews, :course_meta_id, :integer
  end
end
