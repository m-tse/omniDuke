class DropAttributeTables < ActiveRecord::Migration
  def up
    drop_table :attributes
    drop_table :attributes_sections
  end

  def down
  end
end
