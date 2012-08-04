class RenameRolesToSessions < ActiveRecord::Migration
  def change
    rename_table :roles, :sections
  end
end
