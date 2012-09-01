# Lazily instantiates a Redis API object needed
REDIS = Hash.new do |hash, key|
  if key == :sidekiq
    # Sidekiq does it's own namespacing, and marshaling breaks it.
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

__END__

# Lazily instantiates a Redis connection when needed
REDIS_CONNECTIONS = Hash.new do |hash, key|
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


REDIS_CONNECTIONS[Rails.application.config.redis_urls[:cache]] = Rails.cache.instance_variable_get(:@data)
