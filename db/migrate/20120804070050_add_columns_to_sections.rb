class AddColumnsToSections < ActiveRecord::Migration
  def change
    add_column :sections, :suffix, :string
    add_column :sections, :type, :string
  end
end
