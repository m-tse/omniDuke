class SubjectsController < ApplicationController
  def show
    @subject = Subject.find(params[:id])
    @courses = @subject.courses.paginate(:page => params[:page], :per_page => 15)
  end


end
