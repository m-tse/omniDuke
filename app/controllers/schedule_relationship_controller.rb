class ScheduleRelationshipController < ApplicationController

    def create
        if !params[:section].blank?
            @section = Section.find(params[:section])
            @schedulator = current_or_guest_user.schedulator
            if !@schedulator.sections.include?(@section)
                @schedulator.sections << @section
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
            @schedulator = current_or_guest_user.schedulator
            if @schedulator.sections.include?(@section)
                @schedulator.sections.delete(@section)
            end
            respond_to do |format|
                format.html { redirect_to schedulator_index_path }
                format.js
            end
        else
            flash[:error] = "ERROR in ScheduleRelationshipController.destroy"
            redirect_to root_path
        end
    end
    
end
