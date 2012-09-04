require 'active_support/ordered_options'

# Creates a top-level constant REDIS, allowing access to Redis objects. Lazily instantiates a
# connection when accessed. Use it like REDIS.cache or REDIS.resque
REDIS = ActiveSupport::OrderedOptions.new do |hash, key|
  settings = Rails.application.config.redis_settings[key]
  case key
  when :sidekiq
    # Sidekiq needs a Redis::Namespace or a String in order to control the namespace
    hash[key] = Sidekiq.instance_variable_get(:@redis)

  when :cache
    # Since the cache will have been set up in application.rb, get the Redis object from that
    # Cache::RedisStore instance in order to avoid two connections to the same server for the same
    # namespace
    hash[key] = Rails.cache.instance_variable_get(:@data)

  when :profiler
    hash[key] = Redis::Namespace.new(settings[:namespace], redis: Redis.new(settings))

  when :i18n
    hash[key] = I18n.backend[0].instance_variable_get(:@store)

  else
    # The factory will handle namespacing and marshaling and all kinds of goodies.  For more info,
    # see https://github.com/jodosha/redis-store/blob/master/redis-store/lib/redis/factory.rb
    hash[key] = Redis::Factory.create(settings)

  end
end
