class ApplicationController < ActionController::Base
  before_action :github_api

  private

  def github_api
    @github = Github.new
  end
end
