class CourseReviewsController < ApplicationController
  def show
  	@course = Course.find(params[:id])
  	@course_meta = CourseMeta.find(@course.course_meta_id)
  	@course_reviews = @course_meta.course_reviews
  end

  def new
  	@review = CourseReview.new
  	@review.course_meta = CourseMeta.find(params[:course_meta_id])
  end

  def index
  	@course = Course.find(params[:id])
  	@course_meta = CourseMeta.find(@course.course_meta_id)
  	@course_reviews = @course_meta.course_reviews
  end
end
