class CreateCourseInstructorRelations < ActiveRecord::Migration
  def change
    create_table :course_instructor_relations do |t|
      t.string :instructor_status
      t.integer :instructor_id
      t.integer :course_id
      t.timestamps
    end
  end
end
