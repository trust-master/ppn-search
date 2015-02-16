# web:                bundle exec rails server thin -p $PORT
web:                bin/unicorn -p $PORT -c ./config/unicorn.rb
worker:             bin/sidekiq -C ./config/sidekiq.yml
