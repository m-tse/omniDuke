class SearchesController < ApplicationController


  def results

    @omni_search = Sunspot.search Course, Instructor do |query|
      query.keywords params[:search]
    end
    @omni_results = @omni_search.results



  end
end
