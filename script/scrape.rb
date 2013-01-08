#!/usr/bin/env ruby


alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#alphabet = "A"
threads = {}
commands = {}
alphabet.each_char do |letter|
  threads[letter] = Thread.new do
    commands[letter] = "rake db:scrape[#{letter}] --trace"
    puts commands[letter]
    count = 0
    begin
      status = system(commands[letter])
      if not status
        raise
      end
    rescue
=begin
      if count >= 10
        exit
      end
      count += 1
=end
      retry
    end
  end
  if letter == "P"
    threads["P15"] = Thread.new do
      begin
        commands["P15"] = "rake db:scrape[#{letter},15] --trace"
        status = system(commands["P15"])
        if not status
          raise
        end
      rescue
        retry
      end
    end
  end
end
threads.each_value do |thread|
    thread.join
end

