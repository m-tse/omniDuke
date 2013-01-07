class CreateActiveSchedulatorRelationships < ActiveRecord::Migration
  def change
    create_table :active_schedulator_relationships do |t|

      t.timestamps
    end
  end
end
