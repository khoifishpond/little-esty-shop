class GithubService < ApiService
  BASE_URL = 'https://api.github.com'

  def repo
    get_data("#{BASE_URL}/repos/hschmid516/little-esty-shop")
  end

  def contributors
    get_data("#{BASE_URL}/repos/hschmid516/little-esty-shop/stats/contributors")
  end

  def pull_requests
    get_data("#{BASE_URL}/search/issues?q=repo:hschmid516/little-esty-shop%20is:pull-request")
  end
end
