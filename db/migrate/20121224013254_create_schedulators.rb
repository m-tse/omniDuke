class CreateSchedulators < ActiveRecord::Migration
  def change
    create_table :schedulators do |t|

      t.timestamps
    end
  end
end
