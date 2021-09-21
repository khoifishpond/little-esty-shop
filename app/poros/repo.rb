class Repo
  attr_reader :name, :url, :pull_requests

  def initialize(repo_data, pr_data)
    @name = repo_data[:name]
    @url = repo_data[:html_url]
    @pull_requests = pr_data[:total_count]
  end
end
