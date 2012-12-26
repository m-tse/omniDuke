class BookbagRelationshipController < ApplicationController

  def create
  	if !params[:section].blank?
  	  @section = Section.find(params[:section])
  	  if !current_user_or_guest_user.sections.include?(@section)
  	  	current_user_or_guest_user.sections << @section
  	  end
  	end
    if !params[:course].blank?
  	 @course = Course.find(params[:course])
  	 respond_to do |format|
  	   format.html { redirect_to @course }
       format.js
  	 end
    end
  end

  def destroy 
    if !params[:section].blank?
      @section = Section.find(params[:section])
      if current_user_or_guest_user.sections.include?(@section)
        current_user_or_guest_user.sections.delete(@section)
      end
    end
    if !params[:course].blank?
      @course = Course.find(params[:course])
      respond_to do |format|
        format.html { redirect_to @course }
        format.js
      end
    end
  end

end
