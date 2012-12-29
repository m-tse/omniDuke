class BookbagRelationshipController < ApplicationController

  def create
  	if !params[:course].blank?
  	  @course = Course.find(params[:course])
  	  if !current_or_guest_user.courses.include?(@course)
  	  	current_or_guest_user.courses << @course
  	  end
      respond_to do |format|
        format.html { redirect_to @course }
        format.js
     end
  	end
    
  end

  def destroy 
    if !params[:course].blank?
      @course = Course.find(params[:course])
      if current_or_guest_user.courses.include?(@course)
        current_or_guest_user.courses.delete(@course)
      end
      respond_to do |format|
        format.html { redirect_to @course }
        format.js
      end
    end
  end

end
