module Jobs
  module Scrapers
    class AbstractScraper

      def agent
        @agent ||= Mechanize.new
      end

    end
  end
end