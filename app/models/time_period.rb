class TimePeriod < ActiveRecord::Base
  attr_accessible :start_time, :end_time, :day
  belongs_to :time_slot

  
  def startTimeString
    self.start_time.strftime("%I:%M %p")
  end
 
  
  def endTimeString
   self.end_time.strftime("%I:%M %p")
  end
 
end
