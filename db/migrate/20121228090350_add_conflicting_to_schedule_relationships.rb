class AddConflictingToScheduleRelationships < ActiveRecord::Migration
  def change
    add_column :schedule_relationships, :conflicting, :boolean
  end
end
