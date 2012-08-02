class Session < ActiveRecord::Base
  attr_accessible :name, :season, :year
  validates :season, :name, :year, :presence => true
  has_many :courses, :inverse_of => :session

end
