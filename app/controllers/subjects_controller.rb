class SubjectsController < ApplicationController

  def show
    @subject = Subject.find(params[:id])
    @courses = @subject.courses.where(:session_id=>current_or_guest_user.session)
    @instructors = @subject.instructors_by_count
  end

  def index
    currentUser = current_or_guest_user
    if(params[:currentSession]!=nil) 
      currentUser.session=Session.find_by_name(params[:currentSession])
      currentUser.save
    end

    @subjects = Subject.includes(:courses).where("courses.session_id IN(?)", currentUser.session.id)
  end

  def results
    @search = Subject.search do
      fulltext params[:search]
    end
    @subjects = @search.results
  end

  def show_courses
    @subject = Subject.find(params[:id])
    @courses = @subject.courses.where(:session_id=>current_or_guest_user.session).paginate(:page => params[:page], :per_page => 15)
  end

  def show_instructors
    @subject = Subject.find(params[:id])
    @instructors = Instructor.select{|i|
      i.subjects_by_count.include?(@subject)
    }
  end


end
