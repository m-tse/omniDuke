class BookbagRelationship < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id", class_name: "User" 
  belongs_to :section, foreign_key: "section_id", class_name: "Section"
end
