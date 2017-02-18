class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:index]

  def logged_in?
    redirect_to new_session_url
  end

  def index
    @users = User.all
  end

  def show
    set_user
  end


  def new
    @user = User.new
  end


  def edit
    set_user
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url
    else
      flash[:error] = @user.errors.full_messages
      render :new
    end
  end


  def update
    set_user
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end


  def destroy
    set_user
    @user.destroy
    redirect_to users_url
  end

  private

    def set_user
      @user = User.find(params[:id])
    end


    def user_params
      params.require(:user).permit(:username, :password_digest, :session_token, :password)
    end
end
