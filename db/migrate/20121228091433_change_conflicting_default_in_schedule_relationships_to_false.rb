class ChangeConflictingDefaultInScheduleRelationshipsToFalse < ActiveRecord::Migration
  def up
    change_column :schedule_relationships, :conflicting, :boolean, default: false
  end

  def down
  end
end
