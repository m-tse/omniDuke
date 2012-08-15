class DropCourseAttributes < ActiveRecord::Migration
  def up
    drop_table :course_attributes
  end

  def down
  end
end
