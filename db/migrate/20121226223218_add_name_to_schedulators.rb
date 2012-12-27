class AddNameToSchedulators < ActiveRecord::Migration
  def change
    add_column :schedulators, :name, :string
  end
end
