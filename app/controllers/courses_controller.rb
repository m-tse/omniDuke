class CoursesController < ApplicationController
  def show
    @course = Course.find_by_id(params[:id])
    @reviews = Review.where("course_id = ?", params[:id])
  end

  def index
    @subjects = Subject.all
  end

  def results
    @search = Course.search do |q|
      p params
      q.fulltext params[:search]
      params[:attributes].each_pair do |k,v|
        if v=="1"
      q.with(:attributes, [k])
        end
      end


    end
    @courses = @search.results

  end
end


