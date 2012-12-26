class SchedulatorController < ApplicationController

    def index
        @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        if current_or_guest_user.schedulator.nil?
            current_or_guest_user.create_schedulator
        end
        @schedulator = current_or_guest_user.schedulator 
    end

    def show
        @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    end

    def schedule
    end

    def unschedule
    end

end
