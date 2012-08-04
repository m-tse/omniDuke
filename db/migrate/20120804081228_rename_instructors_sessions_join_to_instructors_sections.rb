class RenameInstructorsSessionsJoinToInstructorsSections < ActiveRecord::Migration
  def change
    rename_table :instructors_sessions, :instructors_sections
  end
end
