class RemoveOldNumbersAndNewNumbers < ActiveRecord::Migration
  def change
    remove_column :courses, :old_number
    remove_column :courses, :new_number
    remove_column :course_numberings, :old_number
    remove_column :course_numberings, :new_number

  end
end
