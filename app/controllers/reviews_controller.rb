class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
  end

  def new
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
