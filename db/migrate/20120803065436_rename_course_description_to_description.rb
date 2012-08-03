class RenameCourseDescriptionToDescription < ActiveRecord::Migration
  def change
    remove_column :courses, :course_description
    add_column :courses, :description, :text
  end
end
