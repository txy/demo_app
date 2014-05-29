module SessionsHelper
  #登录
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
    self.current_user = user
  end
  def signed_in?
    !current_user.nil?
  end 
  def signed_in_user
    #redirect_to signin_url, notice: "Please sign in." unless signed_in?
    unless signed_in?
      store_location 
      redirect_to signin_url , notice: "Please sign in."
    end
  end
  #判断是否是当前用户
  def current_user?(user)
    user == current_user
  end 
  def current_user=(user)
    @current_user = user
  end 
  def current_user 
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(remember_token)
  end
  #注销
  def sign_out 
    current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  #返回之前页面
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  def store_location 
    session[:return_to] = request.fullpath if request.get?
  end
end

