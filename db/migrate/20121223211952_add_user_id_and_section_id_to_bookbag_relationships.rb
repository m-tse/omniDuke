class AddUserIdAndSectionIdToBookbagRelationships < ActiveRecord::Migration
  def change
    add_column :bookbag_relationships, :user_id, :integer
    add_column :bookbag_relationships, :section_id, :integer
  end
end
