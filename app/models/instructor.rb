class Instructor < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :name
  has_and_belongs_to_many :sections
  has_many :courses, :through => :sections, :uniq => true
  validates :name, presence:true, uniqueness: { case_sensitive: false }

  has_many :reviews

  before_validation { self.name = self.name.downcase }

  def toString
    capitalize(self.name)
  end
end
