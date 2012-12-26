class CreateSchedulatorSavedRelationships < ActiveRecord::Migration
  def change
    create_table :schedulator_saved_relationships do |t|

      t.timestamps
    end
  end
end
