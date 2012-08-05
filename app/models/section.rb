class Section < ActiveRecord::Base
  attr_accessible :suffix, :section_type, :location, :enrollment, :capacity, :waitlist_enrollment, :waitlist_capacity, :class_number
  has_and_belongs_to_many :instructors
  belongs_to :course
  belongs_to :time_slots
end
