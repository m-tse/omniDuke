class AddViewingBooleanToBookbagRelationships < ActiveRecord::Migration
  def change
    add_column :bookbag_relationships, :viewing, :boolean, default: false
  end
end
