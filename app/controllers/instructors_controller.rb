class InstructorsController < ApplicationController

  def index
    @instructors = Instructor.all
  end

  def show
    @instructor = Instructor.find_by_id(params[:id])
  end

end
