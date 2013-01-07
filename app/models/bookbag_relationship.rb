class BookbagRelationship < ActiveRecord::Base
  attr_accessible :viewing
  belongs_to :user, foreign_key: "user_id", class_name: "User" 
  belongs_to :course, foreign_key: "course_id", class_name: "Course"
end
