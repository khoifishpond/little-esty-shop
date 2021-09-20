class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :github_api

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def github_api
    @github = Github.new
  end
end
