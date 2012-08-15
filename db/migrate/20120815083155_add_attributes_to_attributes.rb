class AddAttributesToAttributes < ActiveRecord::Migration
  def change
    add_column :attributes, :abbr, :string
    add_column :attributes, :name, :string
  end
end
