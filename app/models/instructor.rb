class Instructor < ActiveRecord::Base
  attr_accessible :name
  has_many :roles
  has_many :courses, :through => :roles
  validates :name, :presence => true
end
