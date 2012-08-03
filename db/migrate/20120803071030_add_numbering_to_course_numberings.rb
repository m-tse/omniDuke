class AddNumberingToCourseNumberings < ActiveRecord::Migration
  def change
    add_column :course_numberings, :new_number, :string
    add_column :course_numberings, :old_number, :string
  end
end
