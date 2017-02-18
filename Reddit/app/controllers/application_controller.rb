class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil unless session[:session_token]
    @user = User.find_by_session_token(session[:session_token])
    @user
  end

  def require_login
    current_user
    redirect_to subs_url if @user
  end

end
