class Section < ActiveRecord::Base
  attr_accessible :location, :enrollment, 
                  :capacity, :waitlist_enrollment, 
                  :waitlist_capacity, :class_number, 
                  :description, :synopsis, 
                  :parsedUnits, :name, 
                  :list_description, :room, 
                  :units, :career, 
                  :grading, :campus, 
                  :required_sections, :abbr
#  validates :suffix, :section_type, :location, :enrollment, :capacity, :waitlist_enrollment, :waitlist_capacity, :class_number, presence:true

  has_and_belongs_to_many :course_attributes
  has_and_belongs_to_many :instructors
  has_many :schedulator_relationship
  belongs_to :course
  belongs_to :time_slot

  def isAnchor?
    self.required_sections=="n/a"
  end

  def hasDay?(day)
      days = self.time_slot.aces_value.split(" ",2)[0]
      return days.include?(dayToAbbr(day)) 
  end


  def getTimeSlotStr
      times = self.time_slot.aces_value.split(" ",2)[1]
      return timeSlotToStr(times) 
  end

  def getTimeSlotStrFormatted
      time = String.new(self.time_slot.aces_value.split(" ",2)[1])
      return time
  end

  def dayToAbbr(dayName)
      if dayName.start_with?("T")
          return dayName[0..1]
      else
          return dayName[0]
      end
  end

  def timeSlotToStr(timeInfo) 
      timeInfoCopy = String.new(timeInfo)
      timeInfoCopy.slice!(':')
      timeInfoCopy.slice!(':')
      return timeInfoCopy.split('-').join("to").gsub(/\s+/, "")
  end

  # Does not work on aces values with multiple slots
  def getDaysAsStrArray
      dayAbbrs = { "Su" => "Sun", 
                   "M"  => "Mon", 
                   "Tu" => "Tue", 
                   "W"  => "Wed", 
                   "Th" => "Thu", 
                   "F"  => "Fri", 
                   "Sa" => "Sat" }
      days = self.time_slot.aces_value.split(" ",2)[0]
      daysStrArray = Array.new
      dayAbbrs.keys.each do |abbr|
          if days.slice(abbr) 
            daysStrArray << dayAbbrs[abbr]
          end
      end
      return daysStrArray
  end

end
