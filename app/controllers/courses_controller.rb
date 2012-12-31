class CoursesController < ApplicationController
  def show
    @course = Course.find_by_id(params[:id])
    #@reviews = Review.where("course_id = ?", params[:id])
  end

  def index
    currentUser = current_or_guest_user
    if(params[:currentSession]!=nil) 
      currentUser.session=Session.find_by_name(params[:currentSession])
      currentUser.save
    end


    @subjects = Subject.includes(:courses).where("courses.session_id IN(?)", currentUser.session.id).sort_by &:abbr
    #here so the check boxes work
    @attributes = {"hidden"=>"true"}
  end

  def results
    #for check boxes
    @attributes = params[:attributes]
    @search = Course.search do |q|
      q.fulltext params[:search]
      if params[:attributes]!=nil
        params[:attributes].each_pair do |k,v|
          if v=="true" and k!="hidden"
            q.with(:attributes, [k])
          end
        end
      end
    end
    @courses = @search.results
  end

  def side_results
    @search = Course.search do
      fulltext params[:class_search]
    end
    @courses = @search.results
    respond_to do |format|
      format.js
    end
  end

end


