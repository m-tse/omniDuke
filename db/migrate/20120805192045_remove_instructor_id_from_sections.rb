class RemoveInstructorIdFromSections < ActiveRecord::Migration
  def change
    remove_column :sections, :instructor_id
  end
end
