class AddRoomLocationToSections < ActiveRecord::Migration
  def change

    add_column :sections, :room, :string
  end
end
