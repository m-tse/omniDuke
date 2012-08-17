class CreateTimePeriods < ActiveRecord::Migration
  def change
    create_table :time_periods do |t|
      t.time :start_time
      t.time :end_time
      t.integer :time_slot_id
      t.integer :day

      t.timestamps
    end
  end
end
