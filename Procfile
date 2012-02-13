web:                bundle exec rails server thin -p $PORT
worker:             bundle exec rake resque:work QUEUE=* VERBOSE=1


# Use these in development to aid in running these software. Obviously, you'll need `redis-server`
# binary in your $PATH:

redis_server:  redis-server ./config/development/redis/redis.conf
resque_web:    bundle exec resque-web --server thin -F -L --app-dir ./tmp/resque-web/ --pid-file ./tmp/pids/resque-web.pid --log-file ./log/resque-web.log