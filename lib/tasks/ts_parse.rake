

namespace :ts do 
    desc "Parse time slots into information that can be used in views"
    task parse: :environment do
        puts "Parsing time slot information..."
        parseTimeSlots()
        puts "COMPLETE: timeslot.css.scss generated in assets/stylesheets"
    end
end


def parseTimeSlots
    filename = "#{Rails.root}/app/assets/stylesheets/timeslot.css.scss"
    removeFileIfExists(filename)
    timeSlots = Set.new
    times = TimeSlot.all
    times.each do |time| 
        count = 0
        timeStr = Array.new
        time.aces_value.split(' ').each do |tinfo|
            if tinfo.include?("AM") || tinfo.include?("PM")
                timeStr << tinfo
                count += 1
                if count == 2
                    count = 0
                    timeSlots.add(timeStr.join("-"))
                    timeStr = Array.new
                end
            end
        end
    end
    timeSlots.each do |t|
        writeToCSS(filename, t)
    end
end


def writeToCSS(filename, tinfo)
    helperFilename = "#{Rails.root}/lib/assets/timeCssInfo.txt"
    timeKeys = [
        '8A', '9A', '10A',
        '11A', '12P', '1P', 
        '2P', '3P', '4P',
        '5P', '6P', '7P',
        '8P', '9P', '10P' 
    ]  
    timePositions = Array.new
    timeMap = {}
    File.open(helperFilename, 'r').each_line do |line|
        timePositions << line.chomp.to_i
    end
    timeKeys.zip(timePositions).each do |key,value|
        timeMap[key] = value
    end

    # e.g. range: [1: '8A']
    range = Array.new # Indexes for time keys
    offsets = Array.new
    tinfo.split('-').each do |info|
        timeKey = Array.new
        timeInfo = info.split(':')
        timeKey << timeInfo[0]
        if timeInfo[1].include?("A")
            timeKey << "A"
            offsets << timeInfo[1].chomp("AM").to_i
        elsif timeInfo[1].include?("P")
            timeKey << "P"
            offsets << timeInfo[1].chomp("PM").to_i
        end
        range << timeKeys.index(timeKey.join())
    end

    # YOU CAN MAKE AN EQUIVALENT CHECK EALIER AND
    # SAVE COMPUTATION, but too lazy right now
    if range[0].nil? || range[1].nil? || range[0] < 0 || range[0] > 13 || range[1] < 0 || range[1] > 13
        return 0
    end

    pix = timeMap[timeKeys[range[1]]]-timeMap[timeKeys[range[0]]]

    # Calculate offset i.e. 3:40PM
    isFirst = true
    positionOffset = 0
    range.zip(offsets).each do |rng,offset|
        hourDiff = timeMap[timeKeys[rng+1]]-timeMap[timeKeys[rng]]
        if isFirst 
            isFirst = false
            offs = (hourDiff * offset/60)
            pix -= offs
            positionOffset = timeMap[timeKeys[rng]] + offs
        else
            pix += (hourDiff * offset/60)
        end
    end 
    File.open(filename,'a') do |f|
        cssStr = ["\n.ts", timeSlotToStr(tinfo), 
            " {", 
            "\n\t", 
            "width: ", 
            pix.to_s, 
            "px;", 
            "\n\t",
            "margin-left: ",
            positionOffset.to_s,
            "px;",
            "\n}\n"]
        f.puts cssStr.join()
    end 
    return pix
end

def removeFileIfExists(filename)
    if File.exists? filename
        File.delete(filename)
        puts "Overwriting previous"
    end
end


def timeSlotToStr(timeInfo) 
    timeInfoCopy = String.new(timeInfo)
    timeInfoCopy.slice!(':')
    timeInfoCopy.slice!(':')
    return timeInfoCopy.split('-').join("to")
end
