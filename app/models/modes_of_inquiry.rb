class ModesOfInquiry < ActiveRecord::Base
  attr_accessible :abbr, :name
  validates :abbr, :name, :presence => true
end
