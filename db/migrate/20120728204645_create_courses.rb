class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :semester
      t.text :course_description

      t.timestamps
    end
  end
end
