class AddLocationBackToSections < ActiveRecord::Migration
  def change
    add_column :sections, :location, :string
  end
end
