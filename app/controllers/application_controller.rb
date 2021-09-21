class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_user, :contributor_api, :repo_api

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
       redirect_to root_path
       flash[:notice] = "You must sign in or create an account to access site"
    end
  end

  private

  def repo_api
    repo_data = GithubService.new.repo
    pr_data = GithubService.new.pull_requests
    @repo = Repo.new(repo_data, pr_data)
  end

  def contributor_api
    contributor_data = GithubService.new.contributors
    users = ["timomitchel", "scottalexandra", "jamisonordway", "BrianZanti"]

    @contributors = contributor_data.filter_map do |con|
      Contributor.new(con) unless users.include?(con[:author][:login])
    end
  end
end
