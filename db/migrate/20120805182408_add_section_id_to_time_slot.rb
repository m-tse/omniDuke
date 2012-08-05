class AddSectionIdToTimeSlot < ActiveRecord::Migration
  def change
    rename_table :time_slots, :time_slot
    add_column :time_slot, :section_id, :integer
  end
end
