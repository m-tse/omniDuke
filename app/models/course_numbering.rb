class CourseNumbering < ActiveRecord::Base
  attr_accessible :course_id, :subject_id, :old_number, :new_number
  belongs_to :course, :inverse_of => :course_numberings
  belongs_to :subject
  validates :old_number, :new_number, presence:true
  def toString
    self.subject.abbr + self.new_number+"("+self.old_number+")"
  end

end
