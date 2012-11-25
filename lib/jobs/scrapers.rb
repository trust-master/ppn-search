module Jobs::Scrapers
  class NoResultsError < StandardError; end
  class SanityCheckFailedError < StandardError; end
end