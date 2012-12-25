class AddSchedulatorIdAndSectionIdToSchedulatorRelationship < ActiveRecord::Migration
  def change
    add_column :schedule_relationships, :schedulator_id, :integer
    add_column :schedule_relationships, :section_id, :integer
  end
end
