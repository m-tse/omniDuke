class RenameJoinTable < ActiveRecord::Migration
  def change
    rename_table :attributes_courses, :attributes_sections
  end
end
