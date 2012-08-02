class AddCourseNumberToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :old_number, :integer
    add_column :courses, :new_number, :integer
    add_column :courses, :location, :string
  end
end
