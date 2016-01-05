class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.paginate(page: params[:page], per_page: 10)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "欢迎您注册淘书网!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user && @user.authenticate(edit_user_params[:old_password])
      if @user.update_attributes(name: edit_user_params[:name], password: edit_user_params[:new_password],
                                password_confirmation: edit_user_params[:new_password_confirmation])
        flash[:success] = "个人资料修改成功!"
        sign_in @user
        redirect_to @user
      else
        render 'edit'
      end
    else
      flash.now[:danger] = "原密码输入有误!"
      render 'edit'
    end
  end

  def shelfbooks
    @user = User.find(params[:id])
    @books = @user.books.paginate(page: params[:page], per_page: 10)
    render 'show'
  end

  def my_booklists
    @user = User.find(params[:id])
    @my_booklists = @user.booklists.paginate(page: params[:page], per_page: 10)
  end

  def my_focus_booklists
    @user = User.find(params[:id])
    @my_focus_booklists = @user.my_focus_booklists.paginate(page: params[:page], per_page: 10)
  end

  def fans
    @user = User.find(params[:id])
    @fans = @user.fans.paginate(page: params[:page], per_page: 10)
  end

  def followeds
    @user = User.find(params[:id])
    @followeds = @user.followeds.paginate(page: params[:page], per_page: 10)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def edit_user_params
      params.require(:user).permit(:name, :email, :old_password, :new_password, :new_password_confirmation)
    end

end
