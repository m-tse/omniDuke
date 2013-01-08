class ScheduleRelationshipController < ApplicationController

    $allDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    def create
        if !params[:section].blank?
            @section = Section.find(params[:section])
            @schedulator = Schedulator.find(params[:schedulator])
            if !@schedulator.sections.include?(@section)
                @conflict = false
                @schedulator.sections << @section
                if @schedulator.conflictWith?(@section) # check for time conflict
                    @conflict = true
                    # CONFLICT RESOLUTION
                    # raise "CONFLICT RESOLUTION TIME in ScheduleRelationshipController"
                    @conflicts = @schedulator.getConflictingSections(@section)
                #    conflictsStrBuilder = Array.new
                #    @conflicts.each do |con|
                #        conflictsStrBuilder << con.name
                #    end
                #    @conflictsStr = conflictsStrBuilder.join("<br>")
                #else                    
                    schedrel = getScheduleRelationship(@schedulator, @section)
                    schedrel.conflicting = true
                    schedrel.save
                    @conflicts.each do |con|
                        schedrel = getScheduleRelationship(@schedulator, @section)
                        schedrel.conflicting = true
                        schedrel.save
                    end
                end
            end
            @days = @section.getDaysAsStrArray
            respond_to do |format|
                format.html { redirect_to schedulator_index_path }
                format.js
            end
        else 
            flash[:error] = "ERROR in ScheduleRelationshipController.create"
            redirect_to root_path
        end
    end

    def destroy
        @schedrel = ScheduleRelationship.find(params[:id])
        @section = @schedrel.section
        @schedulator = @schedrel.schedulator
        if @schedulator.sections.include?(@section)
            @schedulator.sections.delete(@section)
        end
        @days = @section.getDaysAsStrArray
        @resolvedIds = Array.new
        if @schedrel.conflicting 
            @schedulator.getConflictingSections(@section).each do |res|
                @resolvedIds << res.id.to_s
            end
        end
        respond_to do |format|
            format.html { redirect_to schedulator_index_path }
            format.js
        end
    end
    
    def replace
        @added = Section.find(params[:added])        
        @schedulator = Schedulator.find(params[:schedulator])
        @conflicts = Array.new
        JSON.parse(params[:conflicts]).each do |id|
            @conflicts << Section.find(id)
        end
        if !@schedulator.sections.include?(@added)
            @schedulator.sections << @added
            @conflicts.each do |con|
                if @schedulator.sections.include?(con)
                    @schedulator.sections.delete(con)
                end
            end
        end
        if @schedulator != current_or_guest_user.current_schedulator
            redirect_to @schedulator
        else
            redirect_to schedulator_index_path
        end
    end


end
