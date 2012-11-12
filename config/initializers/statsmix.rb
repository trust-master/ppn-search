__END__
NotConfiguredError = Class.new(StandardError)

StatsMix.api_key = ENV['STATSMIX_API_KEY'] or raise NotConfiguredError

StatsMix.ignore = Rails.env.development? or Rails.env.testing?

module Metrics
  class AbstractMetric
    def self.name
      self.class.name.humanize
    end

    def self.track(value = nil, options={})
      StatsMix.track(self.name, value, options)
    end
  end

  UserLogins = Class.new(AbstractMetric)
end