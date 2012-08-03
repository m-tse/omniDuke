class RemoveOldNumberAndNewNumberFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :new_number
    remove_column :courses, :old_number
  end

  def down
    add_column :courses, :new_number, :integer
    add_column :courses, :old_number, :integer
  end

end
