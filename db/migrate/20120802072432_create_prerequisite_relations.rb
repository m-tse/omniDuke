class CreatePrerequisiteRelations < ActiveRecord::Migration
  def change
    create_table :prerequisite_relations do |t|
      t.integer :course_id
      t.integer :prerequisite_id
      t.timestamps
    end
  end
end
