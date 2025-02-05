class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :index, :destroy]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def show
	  @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
	  @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Com Tam' Suon Bi Cha!"
      redirect_to @user
    else
		  render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password,
    														 :password_confirmation)
  end

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to static_pages_home_path unless @user
  end

  def correct_user
    redirect_to root_url unless current_user?(@user)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
