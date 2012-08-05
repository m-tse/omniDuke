class TimeSlot < ActiveRecord::Base
  attr_accessible  :end_time, :start_time
  serialize :days_of_week, Array
  #values 1-5, with 1 being monday, 5 being friday
  has_many :sections

  def daysOfWeekToStringArray
    daysOfWeekHash = { 1=>"Monday", 2 => "Tuesday", 3 => "Wednesday",
      4 => "Thursday", 5 => "Friday"}
    retArray = []
    for day in self.days_of_week
      retArray << daysOfWeekHash[day]
    end
    return retArray
  end

  def startTimeString
    self.start_time.strftime("%I:%M %p")
  end

  def endTimeString
    self.end_time.strftime("%I:%M %p")
  end

end
