class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password]) && user.role == 'admin'
      redirect_to admin_path
      flash[:notice] = "Welcome, #{user.username}!"
      session[:user_id] = user.id
    elsif user.authenticate(params[:password])
      redirect_to root_path
      flash[:notice] = "Welcome, #{user.username}!"
      session[:user_id] = user.id
    else
      flash[:notice] = "Sorry, your credentials are bad."
      render :new
    end
  end
end