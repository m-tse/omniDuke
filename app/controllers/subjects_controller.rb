class SubjectsController < ApplicationController
  def show
    @subject = Subject.find(params[:id])
    @courses = @subject.courses
  end


end
