class Schedulator < ActiveRecord::Base
    belongs_to :user
    has_many :schedule_relationship
    has_many :sections, through: :schedule_relationship


    $LOGGING = false
    $filename = "#{Rails.root}/timeConflict.log"
    $log = nil

    def openLog
        if $LOGGING
            $log = File.open($filename, 'a')
            $log.write("====================================\n")
            $log.write("STARTING TIME CONFLICT CHECK\n")
            $log.write("====================================\n")
        end
    end

    def debug(string)
        if $LOGGING
            $log.write(string)
        end
    end

    def closeLog(result)
        if $LOGGING
            $log.write("====================================\n")
            $log.write("TIME CONFLICT CHECK: #{result}\n")
            $log.write("====================================\n")
            $log.close
        end
    end

    # section: Section model object
    # NEEEEEDS REFACTORING 
    def conflictWith?(section)

        openLog

        # Init data structs
        timeSlotStrs = Array.new
        self.sections.each do |sec|
            timeSlotStrs << sec.time_slot.aces_value 
        end
        days = ["Su", "M", "Tu", "W", "Th", "F", "Sa"]
        timeHash = {} 
        days.each do |day|
            timeHash[day] = Array.new
        end

        count = 0
        sectionDays = Array.new
        timeSlot = Array.new
        timeSlotStrs.each do |tinfo|
            tinfo.split(' ').each do |info|
                if info != "-"
                    if info.include?("AM") || info.include?("PM")
                        timeInfo = createTime(info)
                        debug("INFO: #{info}\n")
                        debug("TIME INFO: #{timeInfo}\n")
                        timeSlot << timeInfo
                        count += 1
                    else # is day information
                        days.each do |day|
                            if info.slice(day)
                                sectionDays << day
                            end
                        end
                    end
                    if count == 2
                        debug("COUNT: #{count}\n")
                        count = 0
                        sectionDays.each do |day|
                            timeHash[day] << timeSlot
                        end
                        debug("TIME SLOT: #{timeSlot}\n")
                        debug("SECTION DAYS: #{sectionDays}\n")
                        sectionDays = Array.new
                        timeSlot = Array.new
                    end
                end
            end
        end

        count = 0
        sectionDays = Array.new
        timeSlot = Array.new
        timeHashSec = {}
        days.each do |day|
            timeHashSec[day] = Array.new
        end

        section.time_slot.aces_value.split(' ').each do |tinfo|
            if tinfo != "-"
                if tinfo.include?("AM") || tinfo.include?("PM")
                    timeInfo = createTime(tinfo)
                    debug("TINFO: #{tinfo}\n")
                    debug("TIME INFO: #{timeInfo}\n")
                    timeSlot << timeInfo
                    count += 1
                else # is day information
                    days.each do |day|
                        if tinfo.slice(day)
                            sectionDays << day
                        end
                    end
                end
                if count == 2
                    debug("COUNT: #{count}\n")
                    count = 0
                    sectionDays.each do |day|
                        timeHashSec[day] << timeSlot
                    end
                    debug("TIME SLOT: #{timeSlot}\n")
                    debug("SECTION DAYS: #{sectionDays}\n")
                    sectionDays = Array.new
                    timeSlot = Array.new
                end
            end
        end

        # Check constraint
        timeHash.keys.each do |day|
            timeHash[day].each do |dateArray|
                timeHashSec[day].each do |dateArraySec|
                    debug("DATE ARRAY: #{dateArray}\n")
                    debug("DATE ARRAY SEC: #{dateArraySec}\n")
                    if intervalsConflict?(dateArray, dateArraySec)
                        closeLog("True")
                        return true
                    end
                end
            end
        end

        closeLog("False")
        return false

    end

    def createTime(tinfo)
        # Just need a valid time to make other times
        today = Time.new
        year = today.year
        month = today.month
        day = today.day
        hour,min = timeStringToIntArray(tinfo)
        debug("HOUR: #{hour}, MIN: #{min}\n")
        return Time.new(year, month, day, hour, min)
    end

    # Expect times e.g. 3:45AM
    def timeStringToIntArray(timeStr)
        timeArray = Array.new
        hour,min = timeStr.split(":")
        debug("STRING HOUR: #{hour}, MIN: #{min}\n")
        hour = hour.to_i
        if min.include?("PM")
            if hour != 12
                hour += 12 
            end
            min = min.chomp("PM").to_i
        elsif min.include?("AM")
            if min == "12AM"
                hour = 0
            end
            min = min.chomp("AM").to_i
        end
        timeArray << hour
        timeArray << min
        return timeArray
    end

    # da = dateArray
    def intervalsConflict?(da1, da2) 
        #test = Array.new
        return (da1[0] < da2[1] && da1[1] >= da2[0] || (da1[0] == da2[0] && da1[1] == da2[1]) || (da1[0] < da2[1] && da1[1] >= da2[1])) 
        #da1.each do |da|
        #    test << "#{da}}"
        #end
        #da2.each do |da|
        #    test << "#{da}}"
        #end
        #raise test.join("")
        #end
        #return false
        
    end

end
