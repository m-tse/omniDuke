class AddMoreColumnsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :synopsis, :text
    add_column :courses, :enrollment, :integer
    add_column :courses, :capacity, :integer
    add_column :courses, :waitlist_capacity, :integer
    add_column :courses, :waitlist_count, :integer
    add_column :courses, :seminar, :boolean
    add_column :courses, :class_number, :integer
  end
end
