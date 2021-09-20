class AdminController < ApplicationController
  before_action :require_admin

  def require_admin
    redirect_to root_path unless user.role == 'admin'
  end
end
