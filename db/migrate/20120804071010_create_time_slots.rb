class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.time :start_time
      t.time :end_time
      t.integer :day_of_week

      t.timestamps
    end
  end
end
