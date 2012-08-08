class Course < ActiveRecord::Base
  attr_accessible :description, :name, :credits
 # validates :name, :description, :credits, :presence => true
  has_many :prerequisite_relations, :foreign_key => "course_id", :class_name=>"PrerequisiteRelation"
  has_many :prerequisites, :through => :prerequisite_relations
  belongs_to :advanced_course, :class_name => "Course"

  has_many :sections
  has_many :instructors, :through => :sections, :uniq => :true


  has_and_belongs_to_many :modes_of_inquiry
  has_and_belongs_to_many :areas_of_knowledge

  belongs_to :session, :inverse_of => :courses

  has_many :course_numberings, :inverse_of => :course
  has_many :subjects, :through => :course_numberings

  #array of course code strings, i.e. CS100
  def courseCodes
    retArray = []
    for course_number in self.course_numberings
      retArray << course_number.toString
    end
    return retArray
  end
  searchable do
    text :description, :name
  end


end
