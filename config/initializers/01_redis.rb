# Lazily instantiates a Redis connection when needed
REDIS = Hash.new do |hash, key|
  hash[key] = Redis.connect(url: ServiceProviderPortal::Application.config.redis_urls[key])
end