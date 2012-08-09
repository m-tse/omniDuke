class Session < ActiveRecord::Base
  attr_accessible  :season, :year
  validates :season, :year, :name, :presence => true
  validates :season, :inclusion => { :in => ["spring", "summer", "winter", "fall"]}
  validates :name, uniqueness: { case_sensitive: false }



  has_many :courses, :inverse_of => :session

  before_validation do
    self.season=self.season.downcase
    self.name = self.season+self.year.to_s
  end

  def toString
    capitalize(self.season)+" " +self.year.to_s+ " Term"
  end

end
