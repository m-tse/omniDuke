class RenameSessionIdToSectionIdInInstructorsSections < ActiveRecord::Migration
  def change
    rename_column :instructors_sections, :session_id, :section_id
  end
end
