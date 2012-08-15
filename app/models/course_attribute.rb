class CourseAttribute < ActiveRecord::Base
  attr_accessible :abbr, :name, :scrape_value
  has_and_belongs_to_many :sections
end
