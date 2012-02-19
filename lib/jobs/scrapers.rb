module Jobs
  module Scrapers
    class NoResultsError < StandardError; end
    class SanityCheckFailedError < StandardError; end
  end
end