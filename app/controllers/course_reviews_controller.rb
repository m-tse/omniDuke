class CourseReviewsController < ApplicationController

  def new
    if !user_signed_in?
      flash[:error] = "Must be signed in to review a course."
      redirect_to root_path
    end
  	@review = CourseReview.new
  	@course_meta_id = params[:course_meta_id]
  	@review.course_meta = CourseMeta.find(params[:course_meta_id])
  end

  def index
  	@course = Course.find(params[:format])
  	@course_meta = CourseMeta.find(@course.course_meta_id)
  	@course_reviews = @course_meta.course_reviews
  end

  def create
  	areview = CourseReview.new(params[:course_review])
    if areview.save
      flash[:success] = "Review created!"
      redirect_to root_path
    else
    	flash[:error] = "review not created!"
      redirect_to :action => :new
    end
  end
end
