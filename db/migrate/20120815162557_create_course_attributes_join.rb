class CreateCourseAttributesJoin < ActiveRecord::Migration
  def change
    create_table :course_attributes_sections, :id => false do |t|
      t.integer :course_attribute_id
      t.integer :section_id
    end
  end
end
