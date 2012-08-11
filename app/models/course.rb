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

  has_many :reviews


  #toString with the course code followed by course name
  def toString(subjectID)
      self.toCode(subjectID) +  " - " + self.name
  end

  def toCode(subjectID)
    self.course_numberings.find_by_subject_id(subjectID).toString
  end

  def toDefaultCode
    self.course_numberings.first.toString
  end

  def toDefaultString
    self.toDefaultCode+ " - " + self.name
  end

  searchable do
    text :description
    text :name, :boost => 5
    # bug for some reason only the newer number gets mapped
    text :course_number_new do
      course_numberings.map(&:new_number)
    end
    text :course_number_old do
      course_numberings.map(&:old_number)
    end
    text :subjects_abbr do
      subjects.map(&:abbr)
    end
    text :subjects_name do
      subjects.map(&:name)
    end
    text :subject_alias do
      subjects.map(&:alias)
    end
    #non functioning map by aliases
#    test :subjects, :multiple => true  do
#      subjects.map{|subject| subject.aliases}
#    end
    text :instructors do
      instructors.map(&:name)
    end
  end


end
