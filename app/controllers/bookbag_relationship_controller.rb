class BookbagRelationshipController < ApplicationController

  def edit
    @bookbagRel = BookbagRelationship.find(params[:id])
    if params[:viewing] == "true"
      @bookbagRel.viewing = true
    else
      @bookbagRel.viewing = false
    end     
    @bookbagRel.save
    respond_to do |format|
      format.html { redirect_to schedulator_index_path } 
    end
  end


  def create
  	if !params[:course].blank?
  	  @course = Course.find(params[:course])
  	  if !current_or_guest_user.courses.include?(@course)
  	  	current_or_guest_user.courses << @course
  	  end
      respond_to do |format|
        format.js
     end
  	end
    
  end

  def destroy 
    if !params[:course].blank?
      @course = Course.find(params[:course])
      @sections = @course.sections
      @deleted_sections = Array.new
      schedulator = current_or_guest_user.current_schedulator
      schedulator.sections.each do |sec|
        if @sections.include?(sec) 
          schedulator.sections.delete(sec)
          @deleted_sections << sec
        end
      end
      @days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
      if current_or_guest_user.courses.include?(@course)
        current_or_guest_user.courses.delete(@course)
      end
      respond_to do |format|
        format.js
      end
    end
  end

end
