class DropCourseNumberings < ActiveRecord::Migration
  def up
    drop_table :course_numberings
  end

  def down
  end
end
