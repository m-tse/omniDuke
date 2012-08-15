class CreateCourseAttributes < ActiveRecord::Migration
  def change
    create_table :course_attributes do |t|
      t.string :name
      t.string :abbr

      t.timestamps
    end
  end
end
