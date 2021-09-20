class UsersController < ApplicationController
  skip_before_action :require_user

  def new
    @user = User.new
  end

  def create
    new_user = User.create(user_params)

    if new_user && new_user.role == 'admin'
      session[:user_id] = new_user.id
      redirect_to admin_path
      flash[:notice] = "Welcome, #{user_params[:username]}!"
    else
      session[:user_id] = new_user.id
      redirect_to root_path
      flash[:notice] = "Welcome, #{user_params[:username]}!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :role)
  end
end
