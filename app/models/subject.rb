class Subject < ActiveRecord::Base
  attr_accessible :abbr, :name, :alias
  #alias for this subject, i.e. "cs" for computer science

  validates :abbr, presence:true, uniqueness: { case_sensitive: false}
  validates :name, presence:true, uniqueness: { case_sensitive: false}


#  has_and_belongs_to_many :courses
  has_many :courses

  def toString
    self.abbr + " - " + self.name
  end

  def instructors_by_count
    retarray = []
    instructorHash = {}
    for course in self.courses
      for section in course.sections
        for instructor in section.instructors
          if instructorHash.has_key? instructor
            instructorHash[instructor] += 1
          else
            instructorHash[instructor] = 1
          end
        end
      end
    end
    
    instructorHash.sort_by{|k,v| v}
    instructorHash.each_key {|key| retarray << key }
    return retarray
  end


  searchable do
    text :name, :boost => 2
    text :abbr, :boost => 2
    text :course_names do
      courses.map(&:name)
    end
    text :instructor_names do
      instructors_by_count.map(&:name)
    end
  end

end
