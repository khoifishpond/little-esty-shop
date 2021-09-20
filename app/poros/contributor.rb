class Contributor
  attr_reader :name, :url, :commits

  def initialize(contributor_data)
    @name = contributor_data[:author][:login]
    @url = contributor_data[:author][:html_url]
    @commits = contributor_data[:total]
  end
end
