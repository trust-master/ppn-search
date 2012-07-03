# Lazily instantiates a Redis connection when needed
REDIS = Hash.new do |hash, key|
  if key == :sidekiq
    # Resque does it's own namespacing, and marshaling breaks it.
    hash[key] = Redis.connect(url: Rails.application.config.redis_urls[key])
  elsif key == :cache
    # Get the new Redis object from the new Cache::RedisStore instance in order to avoid two
    # connections to the same server for the same namespace
    hash[key] = Rails.cache.instance_variable_get(:@data)
  else
    # The factory will handle namespacing and marshaling and all kinds of goodies
    hash[key] = Redis::Factory.create(Rails.application.config.redis_urls[key])
  end
end
