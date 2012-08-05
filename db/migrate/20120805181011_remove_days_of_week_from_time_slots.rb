class RemoveDaysOfWeekFromTimeSlots < ActiveRecord::Migration
  def change
    remove_column :time_slots, :day_of_week
  end
end
