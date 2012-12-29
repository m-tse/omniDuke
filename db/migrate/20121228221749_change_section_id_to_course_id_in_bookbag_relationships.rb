class ChangeSectionIdToCourseIdInBookbagRelationships < ActiveRecord::Migration
  def up
    rename_column :bookbag_relationships, :section_id, :course_id 
  end

  def down
  end
end
