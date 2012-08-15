class ChangeColumnsOfJoinTable < ActiveRecord::Migration
  def change
    rename_column :attributes_sections, :course_id, :section_id
  end
end
