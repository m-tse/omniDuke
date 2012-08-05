class AddIndexToInstructorName < ActiveRecord::Migration
  def change
    add_index :instructors, :name, unique: true
  end
end
