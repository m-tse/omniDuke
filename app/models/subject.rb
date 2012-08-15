class Subject < ActiveRecord::Base
  attr_accessible :abbr, :name, :alias
  #alias for this subject, i.e. "cs" for computer science

  validates :abbr, presence:true, uniqueness: { case_sensitive: false}
  validates :name, presence:true, uniqueness: {case_sensitive: false}


#  has_and_belongs_to_many :courses
  has_many :course_numberings
  has_many :courses, :through => :course_numberings
end
