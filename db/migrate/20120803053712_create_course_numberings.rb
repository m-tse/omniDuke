class CreateCourseNumberings < ActiveRecord::Migration
  def change
    create_table :course_numberings do |t|
      t.integer :course_id
      t.integer :subject_id
      t.integer :old_number
      t.integer :new_number
      t.timestamps
    end
  end
end
