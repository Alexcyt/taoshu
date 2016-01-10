class BooklistsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :is_booklist_owner, only: [:edit, :update, :destroy]

  def index
    @booklists = Booklist.paginate(page: params[:page], per_page: 15)
  end

  def show
    @booklist = Booklist.find(params[:id])
    session[:cur_booklist] = @booklist.id
    @list_books = @booklist.list_books.paginate(page: params[:page], per_page: 10)
  end

  def new
    @booklist = Booklist.new
  end

  def create
    @booklist = current_user.booklists.new(booklist_params)
    if @booklist.save
      flash[:success] = "推书单创建成功!"
      redirect_to @booklist
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @booklist.update_attributes(booklist_params)
      flash[:success] = "推书单信息修改成功!"
      redirect_to @booklist
    else
      render 'edit'
    end
  end

  def destroy
    @user = @booklist.user
    @booklist.destroy
    flash[:success] = "成功删除书单!"
    redirect_to my_booklists_user_path(@user)
  end

  private

    def booklist_params
      params.require(:booklist).permit(:title, :desc)
    end

    def is_booklist_owner
      @booklist = Booklist.find(params[:id])
      owner = @booklist.user
      redirect_to(root_path) unless current_user?(owner)
    end
end
