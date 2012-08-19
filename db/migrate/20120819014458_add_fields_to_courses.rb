class AddFieldsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :old_number, :string
    add_column :courses, :new_number, :string
    add_column :courses, :subject_id, :integer
  end
end
