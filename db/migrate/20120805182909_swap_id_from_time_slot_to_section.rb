class SwapIdFromTimeSlotToSection < ActiveRecord::Migration
  def change
    remove_column :time_slot, :section_id
    add_column :sections, :section_id, :integer
  end
end
