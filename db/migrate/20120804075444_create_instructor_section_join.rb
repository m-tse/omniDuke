class CreateInstructorSectionJoin < ActiveRecord::Migration
  def change
    create_table :instructors_sessions, :id => false do |t|
      t.integer :instructor_id
      t.integer :session_id
    end
  end
end
