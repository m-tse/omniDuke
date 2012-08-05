class TimeSlot < ActiveRecord::Base
  attr_accessible  :end_time, :start_time
  serialize :days_of_week, Array
  has_many :sections
end
