class CreateCourseInstructorRelations < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role
      t.integer :instructor_id
      t.integer :course_id
      t.timestamps
    end
  end
end
