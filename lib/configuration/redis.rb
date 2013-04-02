# This module contains the logic to determine Redis configuration; the goal is that this is the only
# place where the config/redis.yml file is loaded or even mentioned. It does not attempt to
# initialize any connection with the Redis server, merely assembles the config options needed to do
# so. It needs to remain independent of any Rails-specific code

require File.expand_path('../base', __FILE__)
require 'active_support/core_ext/object/blank'
require 'active_support/ordered_options'

class Redis
  module Configuration
    include BaseConfig

    # This creates a hash which provides lazy-instantiation of the redis settings, based on environment variables
    # and/or the config file. These settings are then consumed by the default_proc assigned to the ::REDIS
    # constant in initializers/01_redis.rb, and are set up to provide automatic namespacing given the
    # `key`
    def redis_settings
      @redis_settings ||= ::ActiveSupport::OrderedOptions.new do |hash, key|
        key = key.downcase.to_sym

        hash[key] = Hash.new.tap do |opts|

          # look for ENV vars specifying a URL for Redis. For Resque, it will look for Redis_URL_Resque
          # and Redis_URL, in that order (case insensitive)
          if keys = ENV.keys.grep(/\ARedis(?:\w+)?_URL(?:_#{key})?\z/i).sort.presence
            url = ENV.values_at(*keys).compact.last
            opts.update Redis::Factory.resolve(url)
          end

          key = nil if key == :default
          opts[:namespace] = [rails_env, opts[:namespace], key.to_s].compact.uniq.join(?:)
        end

      end
    end
  end
end
