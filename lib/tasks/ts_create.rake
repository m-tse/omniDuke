
namespace :ts do 
    desc "Create schedulator time css"
    task create: :environment do
        createTimeCss()
    end
end

def createTimeCss 
    filename = "#{Rails.root}/app/assets/stylesheets/schedulator-times.css.scss"
    helperFilename = "#{Rails.root}/lib/assets/timeCssInfo.txt"
    removeFileIfExists(filename)
    removeFileIfExists(helperFilename)
    start = 53
    increment = 58
    times = [
        "eightAM", "nineAM", "tenAM",
        "elevenAM", "twelvePM", "onePM", 
        "twoPM", "threePM", "fourPM", 
        "fivePM", "sixPM", "sevenPM",
        "eightPM", "ninePM", "tenPM"
    ]
    count = 0
    File.open(filename, 'a') do |f|
        times.each do |time|
            cssStr = [
                "\n.", time, " {",
                "\n\tmargin-left: ",
                start + (increment*count),
                "px;\n}\n"
            ]
            f.puts cssStr.join()
            count += 1
        end
    end
    count = 0
    File.open(helperFilename, 'a') do |f|
        times.each do |time|
            f.puts (start+(increment*count)).to_s
            count += 1
        end
    end
end
