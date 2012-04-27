# web:                bundle exec rails server thin -p $PORT
web:                bundle exec unicorn -p $PORT -c ./config/unicorn.rb

worker:             bundle exec rake resque:work QUEUE=mailers,scrapers,* VERBOSE=1 INTERVAL=1
resque_scheduler:   bundle exec rake resque:scheduler VERBOSE=1


# Use these in development to aid in running these software. Obviously, you'll need `redis-server`
# binary in your $PATH:

redis_server:  redis-server ./config/development/redis/redis.conf
