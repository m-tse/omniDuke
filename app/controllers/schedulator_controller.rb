class SchedulatorController < ApplicationController

    def index
        @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    end

    def show
        @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    end

    def schedule
    end

    def unschedule
    end

end
