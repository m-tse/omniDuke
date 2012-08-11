class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
  end

  def new
    @fieldsHash = {course_content:"Course Content", assignment_easiness:"Assignment Easiness", test_easiness:"Test Easiness", clarity:"Instructor Clarity", helpfulness:"Instructor Helpfulness", enthusiasm:"Instructor Enthusiasm", textbook_usefulness:"Textbook Usefulness"}
    @review = Review.new
  end

  def index
    @reviews = Review.all
  end

  def create
    @review = Review.new(params[:review])
    if @review.save
      flash[:success] = "Review created!"
      redirect_to root_path
    else
      render :new
    end
  end

end
