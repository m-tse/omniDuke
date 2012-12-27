class SchedulatorController < ApplicationController

    $days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    $state = "current"

    # CLEAN UP ALL THE @edits

    def index
        @edit = false
        if !params[:edit].blank?
            @edit = true
            raise "WLKJEAWLKJDAKJ"
        end
        if current_or_guest_user.current_schedulator.nil?
            current_or_guest_user.create_current_schedulator
        end
        @schedulator = current_or_guest_user.current_schedulator
    end

    def show
        $state = "current"
        @edit = true
        @schedulator = Schedulator.find(params[:id])
        respond_to do |format|
            format.html { redirect_to schedulator_index_path }
            format.js
        end
    end

    def show_saved
        @edit = false
        if !params[:edit].blank?
            @edit = true
        end
        $state = "saved"
        @schedulator = Schedulator.find(params[:schedulator])
        respond_to do |format|
            if @edit 
                format.html { redirect_to schedulator_index_path(edit: "true") }
            else
                format.html { redirect_to schedulator_index_path }
            end
            format.js
        end
    end

    def show_current
        @edit = false
        if !params[:edit].blank?
            @edit = true
        end
        $state = "current"
        @schedulator = Schedulator.find(params[:schedulator])
        respond_to do |format|
            if @edit 
                format.html { redirect_to schedulator_index_path(edit: "true") }
            else
                format.html { render schedulator_index_path }
            end
            format.js
        end
    end

end
