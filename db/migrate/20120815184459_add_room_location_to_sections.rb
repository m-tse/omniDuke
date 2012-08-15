class AddRoomLocationToSections < ActiveRecord::Migration
  def change
    add_column :sections, :location, :string
    add_column :sections, :room, :string
  end
end
