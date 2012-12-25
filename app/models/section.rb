class Section < ActiveRecord::Base
  attr_accessible :location, :enrollment, :capacity, :waitlist_enrollment, :waitlist_capacity, :class_number, :description, :synopsis, :parsedUnits, :name, :list_description, :room, :units, :career, :grading, :campus, :required_sections
#  validates :suffix, :section_type, :location, :enrollment, :capacity, :waitlist_enrollment, :waitlist_capacity, :class_number, presence:true

  has_and_belongs_to_many :course_attributes
  has_and_belongs_to_many :instructors
  has_many :bookbag_relationship
  has_many :schedulator_relationship
  belongs_to :course
  belongs_to :time_slot

  def isAnchor?
    self.required_sections=="n/a"
  end

end
