class SubjectsController < ApplicationController
  def show
    @courses = Course.all
    @subject = Subject.find(params[:id])
  end


end
