class CreateScheduleRelationships < ActiveRecord::Migration
  def change
    create_table :schedule_relationships do |t|

      t.timestamps
    end
  end
end
