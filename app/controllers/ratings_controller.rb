class RatingsController < ApplicationController
  before_action :signed_in_user

  def create
    @book = Book.find(params[:rating][:book_id])
    score = params[:rating][:score]
    current_user.rating_book!(@book, score)
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end

  def update
    @book = Rating.find(params[:id]).book
    score = params[:rating][:score]
    current_user.change_rating_book!(@book, score)
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end
end
