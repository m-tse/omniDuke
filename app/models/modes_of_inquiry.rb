class ModesOfInquiry < ActiveRecord::Base
  attr_accessible :abbr
  validates :abbr, presence:true, uniqueness: {case_sensitive: false }
  validates :abbr, :inclusion => { :in => ["W", "CCI", "EI", "STS", "FL", "R"]}

  before_save do
    moiHASH = {"W"=>"Writing", "CCI"=>"Cross-Cultural Inquiry",
      "EI"=>"Ethical Inquiry", "STS" => "Science, Technology, and Society",
      "FL"=> "Foreign Language", "R"=>"Research"}
    self.name=moiHASH[self.abbr]
  end
  has_and_belongs_to_many :courses
end
