class CourseReviewsController < ApplicationController
  def show
  	@course = Course.find(params[:id])
  	@course_meta = CourseMeta.find(@course.course_meta_id)
  	@course_reviews = @course_meta.course_reviews
  end

  def new
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
      render :new
    end
  end
end
