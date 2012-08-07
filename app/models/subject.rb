class Subject < ActiveRecord::Base
  attr_accessible :abbr, :name

  validates :abbr, presence:true, uniqueness: { case_sensitive: false}
  validates :name, presence:true, uniqueness: {case_sensitive: false}

  before_save do
    self.name = self.name.downcase
    self.abbr = self.abbr.upcase
  end


#  has_and_belongs_to_many :courses
  has_many :course_numberings
  has_many :courses, :through => :course_numberings
end
