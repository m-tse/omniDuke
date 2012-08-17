class InstructorsController < ApplicationController

  def index
    @instructors = Instructor.all.sort_by &:name
  end

  def show
    @instructor = Instructor.find_by_id(params[:id])
  end

  def results
    @search = Instructor.search do
      fulltext params[:search]
    end
    @instructors = @search.results
  end


  
end
