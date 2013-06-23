class InstructorReviewsController < ApplicationController
  def new
    if !user_signed_in?
      flash[:error] = "Must be signed in to review an instructor."
      redirect_to root_path
    end
  	@review = InstructorReview.new
  	@instructor_id = params[:instructor_id]
    @review.instructor = Instructor.find(params[:instructor_id])
  end


  def create
  	areview = InstructorReview.new(params[:instructor_review])
    if areview.save
      flash[:success] = "Review created!"
      redirect_to root_path
    else
    	flash[:error] = "review not created!"
      redirect_to :action => :new
    end
  end
end
