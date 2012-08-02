class CreateAreasOfKnowledges < ActiveRecord::Migration
  def change
    create_table :areas_of_knowledges do |t|
      t.string :name
      t.string :abbr

      t.timestamps
    end
  end
end
