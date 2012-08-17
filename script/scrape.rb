#!/usr/bin/env ruby


command = "rake db:populate --trace"
puts command
count = 0
begin
    status = system(command)
    if not status
        raise
    end
rescue
    if count >= 3
        exit
    end
    count += 1
    retry
end

