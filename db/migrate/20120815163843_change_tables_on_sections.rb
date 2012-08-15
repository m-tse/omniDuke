class ChangeTablesOnSections < ActiveRecord::Migration

  def change
    add_column :sections, :list_name, :string
    remove_column :sections, :section_type
  end
end
