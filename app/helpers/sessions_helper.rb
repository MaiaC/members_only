module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    user.generate_remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_cookie] = user.remember_cookie
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_cookie])
        log_in user
        @current_user = user
      end
    end
  end

  def log_out
    current_user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_cookie)
    session.delete(:user_id)
    current_user = nil    
  end

  def logged_in?
    !current_user.nil?
  end
end
