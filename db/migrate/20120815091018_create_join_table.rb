class CreateJoinTable < ActiveRecord::Migration
  def change
    create_table :attributes_sections, :id => false do |t|
      t.integer :attribute_id
      t.integer :section_id
    end
  end
end
