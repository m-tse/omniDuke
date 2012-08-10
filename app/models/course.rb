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
    text :course_numberings do
      course_numberings.map do |course_numbering|
        course_numbering.new_number
        course_numbering.old_number
      end
    end

    text :subjects do
      subjects.map(&:abbr)
    end
    text :subjects do
      subjects.map(&:name)
    end
    #non functioning map by aliases
 #   test :subjects do
 #     subjects.map{|subject| subject.aliases.first}
 #   end
    text :instructors do
      instructors.map(&:name)
    end
  end


end
