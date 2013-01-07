class CreateCourseMeta < ActiveRecord::Migration
  def change
    create_table :course_meta do |t|
    	t.string :course_name
      t.timestamps
    end
  end
end
