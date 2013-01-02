class ScheduleRelationshipController < ApplicationController

    def create
        if !params[:section].blank?
            @section = Section.find(params[:section])
            @schedulator = Schedulator.find(params[:schedulator])
            if !@schedulator.sections.include?(@section)
                @conflict = false
                if @schedulator.conflictWith?(@section) # check for time conflict
                    # CONFLICT RESOLUTION
                    # raise "CONFLICT RESOLUTION TIME in ScheduleRelationshipController"
                    @conflicts = @schedulator.getConflictingSections(@section)
                    @conflict = true 
                    conflictsStrBuilder = Array.new
                    @conflicts.each do |con|
                        conflictsStrBuilder << con.name
                    end
                    @conflictsStr = conflictsStrBuilder.join("<br>")
                else                    
                    @schedulator.sections << @section
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
        if !params[:section].blank?
            @section = Section.find(params[:section])
            @schedulator = Schedulator.find(params[:schedulator])
            if @schedulator.sections.include?(@section)
                @schedulator.sections.delete(@section)
            end
            @days = @section.getDaysAsStrArray
            respond_to do |format|
                format.html { redirect_to schedulator_index_path }
                format.js
            end
        else
            flash[:error] = "ERROR in ScheduleRelationshipController.destroy"
            redirect_to root_path
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
