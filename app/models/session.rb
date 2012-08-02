class Session < ActiveRecord::Base
  attr_accessible :name, :season, :year
  validates :season, :name, :year, :presence => true
end
