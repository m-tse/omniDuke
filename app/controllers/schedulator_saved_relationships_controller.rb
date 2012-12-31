class SchedulatorSavedRelationshipsController < ApplicationController

    def create
        @schedulator = current_or_guest_user.current_schedulator
        if !@schedulator.nil?
            @schedulator.name = params[:name]
            current_or_guest_user.schedulators << @schedulator
            current_or_guest_user.create_current_schedulator
        end
        respond_to do |format|
            flash[:success] = "Saved schedule"
            format.js
        end
    end

    def destroy
        @relationship = SchedulatorSavedRelationship.find(params[:id])
        @schedulator = @relationship.schedulator
        @sid = @schedulator.id
        if current_or_guest_user.schedulators.include?(@schedulator)
            current_or_guest_user.schedulators.delete(@schedulator)
        end
        if current_or_guest_user.active_schedulators.include?(@scheduator)
            current_or_guest_user.active_schedulators.delete(@schedulator)
        end
        @relationship.delete
        @schedulator.delete
        respond_to do |format|
            flash[:notify] = "Schedule deleted"
            format.html { redirect_to schedulator_index_path } 
            format.js
        end
    end

end
