class TimeSlot < ActiveRecord::Base
  attr_accessible :day_of_week, :end_time, :start_time
end
