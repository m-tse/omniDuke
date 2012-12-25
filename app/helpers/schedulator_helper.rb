module SchedulatorHelper

    def getActiveClass(active, index)
        if active.nil?
            return
        elsif (active == "new" && index == 1) || (active == "saved" && index == 2) 
            return "active" 
        end
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

    # Sections: Array of section objects
    # Day: String of day name i.e. "Sun"
    def produceSectionDivs(sections, day)
        # Str array that will be joined to form
        # output string
        allDivs = Array.new
        sections.each do |section|
            days,times = section.time_slot.aces_value.split(" ",2)
            if !days.include?(dayToAbbr(day))
                next
            end
            divClass = timeSlotToStr(times)
            div = ["<div class=",
                '"ts',
                divClass,
                ' redBack',
                '"',
                "></div>"]
            allDivs << div.join()
        end 
        return allDivs.join()
    end


end
