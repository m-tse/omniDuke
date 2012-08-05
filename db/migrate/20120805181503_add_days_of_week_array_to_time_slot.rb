class AddDaysOfWeekArrayToTimeSlot < ActiveRecord::Migration
  def change
    add_column :time_slots, :days_of_week, :text
  end
end
