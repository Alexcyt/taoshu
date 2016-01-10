class ListBooksController < ApplicationController
  before_action :signed_in_user
  before_action :is_booklist_owner

  def new
    @list_book = ListBook.new
  end

  def create
    @list_book = ListBook.new
    book_name = listbook_params[:book_id]
    if book_name.empty?
      flash.now[:danger] = "书籍不能为空!"
      render 'new'
      return
    end
    @book = Book.find_by(name: book_name)
    if @book.nil?
      flash.now[:danger] = "书籍《#{book_name}》不存在！"
      render 'new'
    else
      if listbook_params[:score] == 0
        listbook_params[:score] = 2
      end
      if @booklist.list_books.find_by(book_id: @book.id).nil?
        @list_book = @booklist.list_books.new(book_id: @book.id, score: listbook_params[:score], desc: listbook_params[:desc])
        if @list_book.save
          flash[:success] = "书籍《#{book_name}》成功加入书单!"
          redirect_to @booklist
        else
          render 'new'
        end
      else
        flash.now[:danger] = "书籍《#{book_name}》在本书单中已经存在！"
        render 'new'
      end
    end
  end

  def destroy
    @list_book = ListBook.find(params[:id])
    book_name = @list_book.book.name
    booklist = @list_book.booklist
    flash[:success] = "成功从书单中删除《#{book_name}》!"
    @list_book.destroy
    redirect_to booklist
  end

  private

    def is_booklist_owner
      if session[:cur_booklist]
        @booklist = Booklist.find(session[:cur_booklist])
        owner = @booklist.user
        redirect_to(@booklist) unless current_user?(owner)
      else
        redirect_to root_path
      end
    end

    def listbook_params
      params.require(:list_book).permit(:book_id, :score, :desc)
    end
end
