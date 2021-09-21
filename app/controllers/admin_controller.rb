class AdminController < ApplicationController
  before_action :require_admin

  def require_admin
    unless current_user.role == 'admin'
      redirect_to root_path
      flash[:danger] = "You must be an Admin to access Admin Pages"
    end
  end
end
