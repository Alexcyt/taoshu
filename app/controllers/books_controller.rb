class BooksController < ApplicationController

  def index
    @books = Book.paginate(page: params[:page])
  end

  def show
    @book = Book.find(params[:id])
    session[:cur_book] = params[:id]
    @book_comments = @book.comments.paginate(page: params[:page], per_page: 10)
  end
end
