class SubjectsController < ApplicationController
  def show
    p params
    @subject = Subject.find(params[:id])
    @courses = @subject.courses.paginate(:page => params[:page], :per_page => 15)
  end


end
