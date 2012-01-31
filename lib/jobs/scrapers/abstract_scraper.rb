module Jobs
  module Scrapers
    module AbstractScraper

      # Define a default Queue for the Scrapers
      def queue
        :scrapers
      end

      def agent
        @@agent ||= Mechanize.new
      end

    end
  end
end