class SearchesController < ApplicationController


  def results
    @courseSearch = Course.search do
      fulltext params[:search]
    end
    @course_results = @courseSearch.results

    @instructorSearch = Instructor.search do
      fulltext params[:search]
    end
    @instructor_results = @instructorSearch.results
  end
end
