class RenameColumnNames < ActiveRecord::Migration
  def change
    rename_column :sections, :list_name, :list_description
  end
end
