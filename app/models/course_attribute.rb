class CourseAttribute < ActiveRecord::Base
  attr_accessible :abbr, :name, :scrape_value
  #add a database index for this, I'm too laze
  validates :scrape_value, presence:true, uniqueness: {case_sensitive: false }
  has_and_belongs_to_many :sections

  before_validation {
    self.scrape_value = self.scrape_value.strip
    validateKnownAttributes
  }

  def validateKnownAttributes
    hash = {"QS"=>"Quantitative Studies", "NS"=>"Natural Sciences", "ALP"=>"Arts, Literature, & Performance", "CZ"=>"Civilizations", "SS"=>"Social Sciences", "CCI"=>"Cross Cultural Inquiry", "EI"=> "Ethical Inquiry", "STS"=>"Science, Technology, and Society", "FL"=>"Foreign Language", "R"=>"Research", "W"=>"Writing"}
    hash.each {|key, value|
      if self.scrape_value.include? key and self.scrape_value.include? value
        self.abbr = key
        self.name = value
      end
    }
  end

  def toString
    if self.abbr!=nil
      return self.abbr
    else
      return self.scrape_value
    end 
  end
  
end

