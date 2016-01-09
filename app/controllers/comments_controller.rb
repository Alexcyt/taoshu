class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def index
    page = params[:page]
    if session[:cur_book]
      redirect_to controller: "books", action: "show", id: session[:cur_book], page: page
    else
      redirect_to books_path
    end
  end

  def show
    page = params[:page]
    if session[:cur_book]
      redirect_to controller: "books", action: "show", id: session[:cur_book], page: page
    else
      redirect_to books_path
    end
  end



  def create
    @book = Book.find(params[:comment][:book_id])
    @book_comments = @book.comments.paginate(page: params[:page], per_page: 10)
    current_user.make_comment!(@book, params[:comment][:title], params[:comment][:content])
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @book = @comment.book
    @book_comments = @book.comments.paginate(page: params[:page], per_page: 10)
    current_user.cancel_comment!(@comment)
    respond_to do |format|
      format.html { redirect_to @book}
      format.js
    end
  end
end
