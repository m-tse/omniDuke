class BookbagRelationshipController < ApplicationController

  def create
  	if !params[:user].blank? and !params[:section].blank?
  	  @user = User.find(params[:user])
  	  @section = Section.find(params[:section])
  	  if !@user.sections.include?(@section)
  	  	@user.sections << @section
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
    if !params[:user].blank? and !params[:section].blank?
      @user = User.find(params[:user])
      @section = Section.find(params[:section])
      if @user.sections.include?(@section)
        @user.sections.delete(@section)
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
