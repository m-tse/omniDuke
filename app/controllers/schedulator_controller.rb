class SchedulatorController < ApplicationController

    $days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    $state = "current"

    # CLEAN UP ALL THE @edits
    # Everything needs a big of refactoring, especially the shows
    def index
        if !params[:click_flag].blank?
            $state = "current"
        end
        @edit = false
        if current_or_guest_user.current_schedulator.nil?
            current_or_guest_user.create_current_schedulator
        end
        @schedulator = current_or_guest_user.current_schedulator
        if request.xhr?
            respond_to do |format|
                format.js
            end
        else  
            respond_to do |format|
                format.html
            end
        end
    end

    def show
        $state = "current"
        @edit = true
        @schedulator = Schedulator.find(params[:id])
        if request.xhr?
            respond_to do |format|
                format.html { render schedulator_index_path }
                format.js
            end
        else
            @name = @schedulator.name
            if @schedulator == Schedulator.last
                @name = "This is schedulator#index"
            end
            respond_to do |format|
                format.html
            end
        end
    end

    def show_saved
        @edit = false
        if !params[:edit].blank?
            @edit = true
        end
        $state = "saved"
        @schedulator = Schedulator.find(params[:schedulator])
        if request.xhr?
            respond_to do |format|
                format.html { render schedulator_index_path }
                format.js
            end
        else 
            @name = @schedulator.name
            if @schedulator == Schedulator.last
                @name = "This is schedulator#index"
            end
            respond_to do |format|
                format.html
            end
        end
    end

    def show_current
        @edit = false
        $state = "current"
        @schedulator = Schedulator.find(params[:schedulator])
        if request.xhr?
            respond_to do |format|
                format.html { render schedulator_index_path }
                format.js
            end
        else 
            @name = @schedulator.name
            if @schedulator == Schedulator.last
                @name = "This is schedulator#index"
            end
            respond_to do |format|
                format.html
            end
        end
    end




end
