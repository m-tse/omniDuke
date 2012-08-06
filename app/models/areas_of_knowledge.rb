class AreasOfKnowledge < ActiveRecord::Base
  attr_accessible :abbr
  validates :abbr, presence:true, uniqueness: {case_sensitive: false}
  validates :abbr, :inclusion => { :in => ["NS","ALP", "CZ", "QS", "SS"]}
  has_and_belongs_to_many :courses


  before_save do
    aokHASH = { "NS"=>"Natural Sciences", "ALP"=>"Arts, Literatures, and Performance", "CZ"=>"Civilizations", "QS"=>"Quantitative Studies", "SS"=>"Social Sciences"}
      self.name = aokHASH[self.abbr]
    end

end
