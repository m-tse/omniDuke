class SchedulatorController < ApplicationController

    def index
        @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        if current_or_guest_user.current_schedulator.nil?
            current_or_guest_user.create_current_schedulator
        end
        @schedulator = current_or_guest_user.current_schedulator
    end

    def show
        @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    end

    def show_saved
        respond_to do |format|
            format.html { redirect_to schedulator_index_path } 
            format.js
        end
    end

    def schedule
    end

    def unschedule
    end

end
