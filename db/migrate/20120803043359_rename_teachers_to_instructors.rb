class RenameTeachersToInstructors < ActiveRecord::Migration
  def change
    rename_table :teachers, :instructors
  end
end
