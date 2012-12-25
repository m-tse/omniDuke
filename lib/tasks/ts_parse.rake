

namespace :ts do 
    desc "Parse time slots into information that can be used in views"
    task parse: :environment do
        parseTimeSlots()
    end
end


def parseTimeSlots
    timeSlots = Set.new
    times = TimeSlot.all
    times.each do |time| 
        count = 0
        timeStr = Array.new
        time.aces_value.split(' ').each do |tinfo|
            if count == 2
                count = 0
                timeSlots.add(timeStr.join("-"))
                timeStr = Array.new
            end
            if tinfo.include?("AM") || tinfo.include?("PM")
                p tinfo
                timeStr << tinfo
                count += 1
            end
        end
    end
    timeSlots.each do |t|
        p t, writeToCSS(t)
    end
end


def writeToCSS(tinfo)
    eightam = 50
    nineam = 108
    tenam = 165
    elevenam = 231
    twelvepm = 297
    onepm = 363
    twopm = 420
    threepm = 477
    fourpm = 534
    fivepm = 591
    sixpm = 648
    sevenpm = 705
    eightpm = 762
    ninepm = 819
    tenpm = 876
    elevenpm = 942
    timeMap = {}
    timeMap['8A'] = eightam
    timeMap['9A'] = nineam
    timeMap['10A'] = tenam
    timeMap['11A'] = elevenam
    timeMap['12P'] = twelvepm
    timeMap['1P'] = onepm
    timeMap['2P'] = twopm
    timeMap['3P'] = threepm
    timeMap['4P'] = fourpm
    timeMap['5P'] = fivepm
    timeMap['6P'] = sixpm
    timeMap['7P'] = sevenpm
    timeMap['8P'] = eightpm
    timeMap['9P'] = ninepm
    timeMap['10P'] = tenpm
    timeKeys = Array.new
    filename = '/home/ark5/projects/omniDuke/test.css.scss'
    timeMap.keys.each do |key|
        timeKeys << key
    end
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
            if timeKeys[rng] == '11A'
                p pix,offset,hourDiff
            end
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

def timeSlotToStr(timeInfo) 
    timeInfoCopy = String.new(timeInfo)
    timeInfoCopy.slice!(':')
    timeInfoCopy.slice!(':')
    return timeInfoCopy.split('-').join("to")
end
