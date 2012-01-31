# Use the Resque REDIS that will have been set in config/initializers/01_redis.rb
Resque.redis = REDIS[:resque]