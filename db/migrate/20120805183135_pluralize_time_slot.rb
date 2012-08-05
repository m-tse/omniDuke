class PluralizeTimeSlot < ActiveRecord::Migration
  def change
    rename_table :time_slot, :time_slots
  end
end
