class RemoveRoleFromSection < ActiveRecord::Migration
  def change
    remove_column :sections, :role
  end
end
