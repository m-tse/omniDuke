class ChangeCourseNumberingsToStrings < ActiveRecord::Migration
  def change
    remove_column :courses, :new_number
    remove_column :courses, :old_number

    add_column :courses, :new_number, :string
    add_column :courses, :old_number, :string
  end
end
