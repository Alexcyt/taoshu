module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:danger] = "请先登录!"
      redirect_to signin_path
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or(default)
    if session[:back_to]
      redirect_to(session[:back_to])
      session.delete(:back_to)
    else
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end
  end

end
