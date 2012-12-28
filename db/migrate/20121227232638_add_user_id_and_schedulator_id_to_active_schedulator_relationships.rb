class AddUserIdAndSchedulatorIdToActiveSchedulatorRelationships < ActiveRecord::Migration
  def change
    add_column :active_schedulator_relationships, :user_id, :integer
    add_column :active_schedulator_relationships, :schedulator_id, :integer
  end
end
