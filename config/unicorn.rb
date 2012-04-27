
worker_processes 3 # amount of unicorn workers to spin up
timeout 30         # restarts workers that hang for 30 seconds

# load the app into memory before forking. Important, as the NewRelic agent needs to fully start up,
# and Improperly deployed applications can go into a spawn loop if the application fails to load
preload_app true