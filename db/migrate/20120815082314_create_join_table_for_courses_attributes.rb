class CreateJoinTableForCoursesAttributes < ActiveRecord::Migration
  def change
    create_table :attributes_courses, :id => false do |t|
      t.integer :attribute_id
      t.integer :course_id
    end
  end
end
