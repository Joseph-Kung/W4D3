class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def logout!
    session[:session_token] = nil
    current_user.reset_session_token! if current_user
    @current_user = nil
    redirect_to new_session_url
  end
end
