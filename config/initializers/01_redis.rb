# Lazily instantiates a Redis connection when needed
REDIS = Hash.new do |hash, key|
  hash[key] = Redis::Factory.create(ServiceProviderPortal::Application.config.redis_urls[key])
end

# Get the new Redis object from the new Cache::RedisStore instance in order to avoid two connections
# to the same server for the same namespace
REDIS[:cache] = Rails.cache.instance_variable_get(:@data)