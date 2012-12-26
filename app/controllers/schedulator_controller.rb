class SchedulatorController < ApplicationController

    def index
        @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        if current_user.schedulator.nil?
            current_user.create_schedulator
        end
        @schedulator = current_user.schedulator 
    end

    def show
        @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    end

    def schedule
    end

    def unschedule
    end

end
