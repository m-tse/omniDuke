class MoveFieldsFromCourseToSections < ActiveRecord::Migration
  def change
    remove_column :courses, :enrollment
    remove_column :courses, :capacity
    remove_column :courses, :waitlist_capacity
    remove_column :courses, :waitlist_count
    remove_column :courses, :location
    remove_column :courses, :class_number


    add_column :sections, :enrollment, :integer
    add_column :sections, :capacity, :integer
    add_column :sections, :waitlist_capacity, :integer
    add_column :sections, :waitlist_count, :integer
    add_column :sections, :location, :string
    add_column :sections, :class_number, :integer
  end
end
