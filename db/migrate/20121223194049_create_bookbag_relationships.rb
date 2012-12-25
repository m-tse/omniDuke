class CreateBookbagRelationships < ActiveRecord::Migration
  def change
    create_table :bookbag_relationships do |t|

      t.timestamps
    end
  end
end
