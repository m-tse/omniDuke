class SubjectsController < ApplicationController

  def show_courses
    @subject = Subject.find(params[:id])
    @courses = @subject.courses.paginate(:page => params[:page], :per_page => 15)
  end

  def show_instructors
    @subject = Subject.find(params[:id])
    @instructors = Instructor.select{|i|
      i.subjects_by_count.include?(@subject)
    }
  end


end
