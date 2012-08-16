class RemoveExtranneousFieldsFromTimeSlot < ActiveRecord::Migration
  def change
    remove_column :time_slots, :start_time
    remove_column :time_slots, :end_time
    remove_column :time_slots, :days_of_week
  end
end
