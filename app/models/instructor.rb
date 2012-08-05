class Instructor < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :sections
  validates :name, presence:true, uniqueness: { case_sensitive: false }

  before_save { self.name = self.name.downcase }
end
