# require 'faraday'
# require 'pry'
# require 'json'

class Github
  def initialize
    @conn = Faraday.new('https://api.github.com')
  end

  def get_repo_name
    repo[:name]
  end

  def get_repo_url
    repo[:html_url]
  end

  def repo
    response = @conn.get('/repos/hschmid516/little-esty-shop')
    parse(response)
  end

  def get_contributors
    response = @conn.get('/repos/hschmid516/little-esty-shop/stats/contributors')
    users = ["timomitchel", "scottalexandra", "jamisonordway", "BrianZanti"]
    parse(response).each_with_object({}) do |contributor, acc|
      acc[contributor[:author][:login]] =  [contributor[:author][:html_url], contributor[:total]] unless users.include?(contributor[:author][:login])
    end
  end

  def pull_requests
    response = @conn.get('/search/issues?q=repo:hschmid516/little-esty-shop%20is:pull-request')
    parse(response)[:total_count]
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
