class InstructorsController < ApplicationController

  def index
    @instructors = Instructor.all.sort_by &:name
    @subjects = Subject.all.sort_by &:abbr
  end

  def show
    @instructor = Instructor.find_by_id(params[:id])
    @reviews = @instructor.instructor_reviews
  end

  def results
    @search = Instructor.search do
      fulltext params[:search]
    end
    @instructors = @search.results
  end


  
end
