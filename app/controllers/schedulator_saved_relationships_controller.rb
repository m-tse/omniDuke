class SchedulatorSavedRelationshipsController < ApplicationController

    def create
        @schedulator = current_or_guest_user.current_schedulator
        if !@schedulator.nil?
            current_or_guest_user.schedulators << @schedulator
            current_or_guest_user.create_current_schedulator
        end
        respond_to do |format|
            flash[:success] = "Saved schedule"
            format.html { redirect_to schedulator_index_path }
        end
    end

    def destroy

    end

end
