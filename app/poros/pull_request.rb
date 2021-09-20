class PullRequest
  attr_reader :total

  def initialize(pull_request_data)
    @total = pull_request_data[:total_count]
  end
end
