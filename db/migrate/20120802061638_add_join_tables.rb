class AddJoinTables < ActiveRecord::Migration
  def change 
    create_table :courses_teachers, :id => false do |t|
      t.integer :course_id
      t.integer :teacher_id
    end

    create_table :courses_sessions, :id => false do |t|
      t.integer :course_id
      t.integer :session_id
    end

    create_table :courses_modes_of_inquiries, :id => false do |t|
      t.integer :course_id
      t.integer :modes_of_inquiry_id
    end

    create_table :areas_of_knowledges_courses, :id => false do |t|
      t.integer :course_id
      t.integer :areas_of_knowledge_id
    end

    create_table :courses_subjects, :id => false do |t|
      t.integer :course_id
      t.integer :subject_id
    end

  end
end
