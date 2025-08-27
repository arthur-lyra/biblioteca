class ReviewsController < ApplicationController
  before_action :set_book

  def create
    @review = @book.reviews.find_or_initialize_by(user: current_user)
    authorize @review
    @review.assign_attributes(review_params.merge(reviewed_at: Time.current))
    if @review.save
      @reviews = @book.reviews.order(created_at: :desc).page(params[:page]).per(10)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @book, notice: "Avaliação registrada." }
      end
    else
      @reviews = @book.reviews.order(created_at: :desc).page(params[:page]).per(10)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @book, alert: @review.errors.full_messages.to_sentence }
      end
    end
  end

  def update
    create
  end

  def destroy
    @review = @book.reviews.find(params[:id])
    authorize @review
    @review.destroy
    @reviews = @book.reviews.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @book, notice: "Avaliação removida." }
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end