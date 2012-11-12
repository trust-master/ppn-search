if defined?(Rack::MiniProfiler)
  Rack::MiniProfiler::RedisStore.class_eval do
    def initialize(args = {})
      @prefix = nil
      @redis = args[:redis]
    end

    def redis
      @redis ||= Redis.new
    end
  end


  Rack::MiniProfiler.config.tap do |config|
    config.storage_instance = Rack::MiniProfiler::RedisStore.new(redis: REDIS.profiler)
    config.use_existing_jquery = true
    config.pre_authorize_cb = proc { |env| Rails.env != 'production' }
    config.skip_paths ||= []
    config.skip_paths += %w[ /images /javascripts /stylesheets ]
  end
end