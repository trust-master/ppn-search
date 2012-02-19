require 'resque-retry'

module Jobs
  module Scrapers
    class AbstractScraper
      extend Resque::Plugins::Retry
      include InheritableClassInstanceVariables

      inheritable_class_instance_variables(:queue, :retry_exceptions, :retry_limit)

      @queue = :scrapers

      # Resque::Plugins::Retry settings
      @retry_exceptions = {
        Mechanize::ResponseCodeError => [5, 10, 20, 30, 60, 120, 240]
        # Add other possible Exceptions to retry on, here
      }

      @retry_limit = 10

      def self.agent
        @@agent ||= Mechanize.new
      end

    end
  end
end