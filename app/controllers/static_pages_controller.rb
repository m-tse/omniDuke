class StaticPagesController < ApplicationController

  def home
    @courses = Course.all
  end
  
end
