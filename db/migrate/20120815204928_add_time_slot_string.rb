class AddTimeSlotString < ActiveRecord::Migration
  def change
    add_column :time_slots, :aces_value, :string
  end
end
