class CourseReviewController < ApplicationController
  def show
  	@course = Course.find(params[:id])
  	@course_meta = CourseMeta.find(@course.course_meta_id)
  	@course_reviews = @course_meta.course_reviews
  end

  def new
  end
end
