class SessionsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      session[:session_token] = @user.reset_session_token!
      redirect_to subs_url
    else
      render :new, text: 'Invalid login or password'
    end
  end

  def destroy
    @user = current_user
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end


  private

  def session_params
    params.require(:user).permit(:username, :password, :session_token)
  end
end
