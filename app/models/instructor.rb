class Instructor < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :courses
  validates :name, :presence => true
end
