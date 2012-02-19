require 'resque-retry'

module Jobs
  module Scrapers
    class AbstractScraper
      extend Resque::Plugins::Retry
      include InheritableClassInstanceVariables

      inheritable_class_instance_variables(:queue, :retry_exceptions, :retry_limit)

      # This will look like this: [ 5, 5, 10, 21, 42, 84, 168, 337, 675, 10, 1350, 10, 2700, 10,
      #                             5400, 10, 10800, 10, 21600, 10, 43200, 10, 86400, 10 ]
      #
      # My reasoning behind this scheme stems from my expirence with the MBLS and DOLI systems.
      # Sometimes they are down completely (for hours [days?]), other times the first attempt for a
      # fetch simply does not work, as if the applications behind these services have race
      # conditions or something
      EXPONENTIAL_BACKOFF = [
        0, (0..6).to_a, (7..14).to_a.map{ |i| [i, 1] }
      ].flatten.map{ |ex| (5.2734375 * 2 ** ex).floor }

      @queue = :scrapers

      # Resque::Plugins::Retry settings
      @retry_exceptions = {
        Mechanize::ResponseCodeError => EXPONENTIAL_BACKOFF # FIXME: Check the HTML error, here, if possible
        # Add other possible Exceptions to retry on, here
      }

      @retry_limit = 28

      def self.agent
        @@agent ||= Mechanize.new
      end

    end
  end
end