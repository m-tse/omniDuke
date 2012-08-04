class Section < ActiveRecord::Base
  attr_accessible :suffix, :section_type
  has_and_belongs_to_many :instructors
  belongs_to :course
end
