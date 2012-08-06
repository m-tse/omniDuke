class Session < ActiveRecord::Base
  attr_accessible  :season, :year
  validates :season, :year, :presence => true
  validates :season, :inclusion => { :in => ["spring", "summer", "winter", "fall"]}
  has_many :courses, :inverse_of => :session

  before_validation do
    self.season=self.season.downcase
  end

  before_save do
    self.name = self.season+self.year.to_s
  end
end
