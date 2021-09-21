class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_user
  # :pull_request_api, :contributor_api, :repo_api

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to root_path unless current_user
  end

  private

  def repo_api
    repo_data = GithubService.new.repo
    @repo = Repo.new(repo_data)
  end

  def contributor_api
    contributor_data = GithubService.new.contributors
    users = ["timomitchel", "scottalexandra", "jamisonordway", "BrianZanti"]

    @contributors = contributor_data.filter_map do |con|
      Contributor.new(con) unless users.include?(con[:author][:login])
    end
  end

  def pull_request_api
    pr_data = GithubService.new.pull_requests
    @pull_request = PullRequest.new(pr_data)
  end
end
