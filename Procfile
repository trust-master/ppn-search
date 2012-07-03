# web:                bundle exec rails server thin -p $PORT
web:                bundle exec unicorn -p $PORT -c ./config/unicorn.rb

worker:             bundle exec sidekiq


# Use these in development to aid in running these software. Obviously, you'll need `redis-server`
# binary in your $PATH:

redis_server:  redis-server ./config/development/redis/redis.conf
