source 'http://rubygems.org'

gem 'rails', '~> 3.1.1'
gem 'pg'

gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem "frontend-helpers"
gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

gem "carrierwave" # CarrierWave allows you to attach files to ActiveRecord Objects
#gem 'aws-s3', require: 'aws/s3' # Access to Amazon S3

gem 'cancan' # for authorization

gem 'simple_form'
gem 'nested_form', git: 'https://github.com/fxposter/nested_form.git'

gem 'rack-webconsole'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# Use thin instead of Webrick. You can use thin instead of webrick using `bundle exec rails server thin` or
# `bundle exec thin start`
gem 'thin', require: false

# Use unicorn as the web server
# gem 'unicorn'

group :development do
  gem 'tailor', git: 'http://github.com/rtlong/tailor.git', require: false

  # Prints db schema tidbits in all the models, tests, and fixtures, also shows `rake routes` output in routes.rb.
  # Use Ryan's fork to get FactoryGirl annotation awesomeness.
  gem 'annotate', require: false

  # Makes development FASTER! Yay! https://github.com/paneq/active_reload
  gem 'active_reload'

  # https://github.com/guard/guard # http://intridea.com/2011/8/25/hire-a-guard-for-your-project
  gem 'guard', '>= 0.8.8', require: false

  # Restart the Rails development server automatically
  gem 'guard-rails', git: 'http://github.com/guard/guard-rails.git', require: false

  # Run the appropriate RSpec test(s) automatically
  gem 'guard-rspec', git: 'http://github.com/guard/guard-rspec.git', require: false

  # Run a shell command automatically
  gem 'guard-shell', git: 'http://github.com/rtlong/guard-shell.git', require: false

  # Annotate models/tests/fixtures/etc when db is modified and routes when routes.rb is changed
  gem 'guard-annotate', git: 'http://github.com/guard/guard-annotate.git', require: false

  gem 'guard-cucumber', require: false
  #gem 'guard-jasmine', require: false

  gem 'guard-bundler', require: false

  gem 'guard-rails_best_practices', '>= 0.1.2', git: 'http://github.com/MatthewHager/guard-rails_best_practices.git', require: false

  gem 'guard-cucumber', require: false
  gem 'guard-spork', require: false

  gem "sass" # Add sass just for generators

  # For seeding my dev DB with fake data
  gem 'faker'
  gem 'populator'
end

group :development, :test do
  gem 'cucumber-rails'
  gem 'spork', '~> 0.9.0.rc'
  gem 'database_cleaner'
  gem 'rspec'
  gem 'capybara'
  gem 'launchy'
end

group :development, :metrics do
  gem 'metrical', require: false
  gem 'metric_fu', git: 'https://github.com/jscruggs/metric_fu.git', require: false
  gem 'flay', require: false
  gem 'flog', require: false
  gem 'reek', git: 'https://github.com/rtlong/reek.git', require: false
  gem 'roodi', git: 'https://github.com/rtlong/roodi.git', require: false
  gem 'Saikuro', git: 'https://github.com/hedtek/Saikuro.git', require: false
  gem 'churn', git: 'https://github.com/danmayer/churn.git', require: false
  gem 'rails_best_practices', git: 'https://github.com/flyerhzm/rails_best_practices.git', require: false
end

group :development, :staging do
  gem 'whereuat', git: 'https://github.com/rtlong/whereuat.git'
end

# Gems only for certain operating system environments.
#
# Avoid installing those which you don't need by adding, for example, `--without windows:linux`
# to your `bundle install` command. You should only need do this once, as it will be remembered.

# Mac OS X
group :darwin do
  # The filesystem event and system notifications that Guard wants, for OS X
  gem 'growl_notify', require: false # Growl notifications
  gem 'rb-fsevent', git: 'git://github.com/ttilley/rb-fsevent.git', branch: 'pre-compiled-gem-one-off', require: false # FSEvent support
end

# Linux
group :linux do
  # The filesystem event and system notifications that Guard wants, for Linux/Unix
  gem 'libnotify',    require: false # Visual notifications
  gem 'rb-inotify',   require: false # inotify support
end

# Windows; commented out until we need them
=begin
group :windows do
  # The filesystem event and system notifications that Guard wants, for Windows
  gem 'rb-notifu',    require: false # Visual notifications
  gem 'rb-fchange',   require: false # Directory Change Notification support
  gem 'win32console', require: false # Support for console colors
end
=end
