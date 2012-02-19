# Use the Resque REDIS that will have been set in config/initializers/01_redis.rb
Resque.redis = REDIS[:resque]

require 'resque-retry'
require 'resque/failure/redis'

# require your jobs & application code.

Resque::Failure::MultipleWithRetrySuppression.classes = [ Resque::Failure::Redis ]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression
