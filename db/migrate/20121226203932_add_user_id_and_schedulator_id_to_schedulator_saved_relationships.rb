class AddUserIdAndSchedulatorIdToSchedulatorSavedRelationships < ActiveRecord::Migration
  def change
    add_column :schedulator_saved_relationships, :user_id, :integer
    add_column :schedulator_saved_relationships, :schedulator_id, :integer
  end
end
