class Instructor < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :sections
  validates :name, presence:true, uniqueness: { case_sensitive: false }

  before_validation { self.name = self.name.downcase }

  def formatted_name
    retstring = ""
    for part in name.split
      retstring=retstring+part.capitalize!+ " "
    end
    return retstring.strip
  end

end
