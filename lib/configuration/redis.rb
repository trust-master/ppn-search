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

    def redis_configuration_file
      @redis_configuration_file ||= rails_root.join('config/redis.yml')
    end

    def redis_defaults
      @redis_defaults ||= begin
        defaults = {
          namespace: rails_env # namespace all redis connections with, for ex. 'production'
        }

        # Try to load some more defaults from the config/redis.yml file
        if File.exists?(redis_configuration_file)
          yml = YAML::load_file(redis_configuration_file)[rails_env].try(:symbolize_keys) rescue {}
          defaults.update(yml)
        end

        defaults
      end
    end


    # This creates a hash which provides lazy-instatiation of the redis settings, based on environment variables
    # and/or the config file. These settings are then consumed by the default_proc assigned to the ::REDIS
    # constant in initializers/01_redis.rb, and are set up to provide automatic namespacing given the
    # `key`
    def redis_settings
      @redis_settings ||= ::ActiveSupport::OrderedOptions.new do |hash, key|
        key = key.downcase.to_sym

        # look for ENV vars specifying a URL for Redis. For Resque, it will look for Redis_URL_Resque
        # and Redis_URL, in that order (case insensitive)
        keys = ENV.keys.grep(/Redis_URL(_#{key})?/i).sort

        hash[key] = redis_defaults.dup.tap do |opts|
          # Try to get a url from the environment variables
          opts[:url] = ENV.values_at(*keys).compact.last || opts[:url]

          # _Add_ the `key` to the namespace, separated by ':'
          key = nil if key == :default
          opts[:namespace] = [opts[:namespace], key.to_s].compact.join(':').presence
        end
      end
    end
  end
end