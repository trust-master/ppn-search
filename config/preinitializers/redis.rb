# This Railtie loads the Redis config into the app config, before the application.rb configure block
# even runs. This way, it's available to use there, for ex. to set up the cache_store

require File.expand_path('../../../lib/configuration/redis', __FILE__)

class Redis
  class Railtie < ::Rails::Railtie
    config.before_configuration do |app|
      # Inject the methods in Redis::Configuration into the app config. This allows us to share the
      # config logic with things that need Redis config, but don't need the full rails environment,
      # like Resque-Scheduler
      app.config.extend Redis::Configuration
    end
  end
end