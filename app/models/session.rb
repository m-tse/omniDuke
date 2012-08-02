class Session < ActiveRecord::Base
  attr_accessible :name, :season, :year
  validates :season, :name, :year, :presence => true
  has_and_belongs_to_many :courses
end
