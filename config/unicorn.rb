
worker_processes 3 # amount of unicorn workers to spin up
timeout 30         # restarts workers that hang for 30 seconds

# load the app into memory before forking. Important, as the NewRelic agent needs to fully start up,
# and Improperly deployed applications can go into a spawn loop if the application fails to load
preload_app true

after_fork do |server, worker|
  ##
  # Unicorn master loads the app then forks off workers - because of the way
  # Unix forking works, we need to make sure we aren't using any of the parent's
  # sockets, e.g. db connection
  ActiveRecord::Base.establish_connection

  Sidekiq.configure_client do |config|
    config.redis = { :size => 1 }
  end

  # Since I couldn't figure out how to establish the Rails cache as Redis-Store, without sticking it
  # in the app.rb config file and initializing it during boot, let's reconnect now
  REDIS.each do |key, redis|
    redis.quit
  end
end
