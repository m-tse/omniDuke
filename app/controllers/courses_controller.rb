class CoursesController < ApplicationController
  def show
    @course = Course.find_by_id(params[:id])
    @reviews = Review.where("course_id = ?", params[:id])
  end

  def index
#    @search = Course.search do
#      fulltext params[:search]
#    end
#    @courses = @search.results
    @courses = Course.all
  end
end

