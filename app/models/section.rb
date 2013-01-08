class Section < ActiveRecord::Base
  attr_accessible :location, :enrollment, 
                  :capacity, :waitlist_enrollment, 
                  :waitlist_capacity, :class_number, 
                  :description, :synopsis, 
                  :parsedUnits, :name, 
                  :list_description, :room, 
                  :units, :career, 
                  :grading, :campus, 
                  :required_sections, :abbr,
                  :view_detail
#  validates :suffix, :section_type, :location, :enrollment, :capacity, :waitlist_enrollment, :waitlist_capacity, :class_number, presence:true

  has_and_belongs_to_many :course_attributes
  has_and_belongs_to_many :instructors
  has_many :schedulator_relationship
  belongs_to :course
  belongs_to :time_slot

  def isAnchor?
    self.required_sections=="n/a"
  end

  # Refactor out the info inlucde logic into own method
  def hasDay?(day)
      tinfo = self.time_slot.aces_value.split(" ")
      tinfo.each do |info|
          if !info.include?("AM") && !info.include?("PM")
              if info.include?(dayToAbbr(day))
                  return true
              end
          end
      end
      return false
  end

  def is_i?(str)
      !!(str =~ /^[-+]?[0-9]+$/)
  end

  def getAllTimeSlotStrs
      strs = Array.new
      days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
      days.each do |day|
        if self.hasDay?(day)
          str = self.getTimeSlotStrFormatted(day)
          if !strs.include?(str)
            strs << str
          end
        end
      end 
      return strs
  end

  # Get time slot string methods do not work if the
  # section does not have the given day
  # Must call section.hasDay?(day) before  
  def getTimeSlotStr(day)
      dayAbbrs = { "Su" => "Sun", 
                   "M"  => "Mon", 
                   "Tu" => "Tue", 
                   "W"  => "Wed", 
                   "Th" => "Thu", 
                   "F"  => "Fri", 
                   "Sa" => "Sat" }
      timeRegex = /(\d+:\d\d((AM)|(PM)) \- \d+:\d\d((AM)|(PM)))/
      tinfo = self.time_slot.aces_value.split(dayAbbrs.key(day), 2)[1]
      time = timeRegex.match(tinfo)[0]
      return timeSlotToStr(time) 
  end

  def getTimeSlotStrFormatted(day)
      dayAbbrs = { "Su" => "Sun", 
                   "M"  => "Mon", 
                   "Tu" => "Tue", 
                   "W"  => "Wed", 
                   "Th" => "Thu", 
                   "F"  => "Fri", 
                   "Sa" => "Sat" }
      timeRegex = /(\d+:\d\d((AM)|(PM)) \- \d+:\d\d((AM)|(PM)))/
      tinfo = self.time_slot.aces_value.split(dayAbbrs.key(day), 2)[1]
      time = timeRegex.match(tinfo)[0]
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

  # Make more efficient with regexes
  def getDaysAsStrArray
      dayAbbrs = { "Su" => "Sun", 
                   "M"  => "Mon", 
                   "Tu" => "Tue", 
                   "W"  => "Wed", 
                   "Th" => "Thu", 
                   "F"  => "Fri", 
                   "Sa" => "Sat" }
      daysStrArray = Array.new
      tinfo = self.time_slot.aces_value.split(" ")
      puts tinfo
      tinfo.each do |info|
          dayAbbrs.keys.each do |abbr|
              if !info.include?("PM") && !info.include?("AM")
                  if info.slice(abbr)  
                      daysStrArray << dayAbbrs[abbr]
                  end
              end
          end
      end 
      return daysStrArray
  end

end
