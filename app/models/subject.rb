class Subject < ActiveRecord::Base
  attr_accessible :abbr, :name
  validates :abbr, :name, :presence => true
  has_and_belongs_to_many :courses
end
