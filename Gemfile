source 'http://rubygems.org'

gem 'rails', '~> 3.2.1'

# Use PostgreSQL
gem 'pg'

# Write views in HAML
gem 'haml'

# Use liquid templates for User-editable templates, i.e. mailers
gem 'liquid'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby'

# CarrierWave allows you to attach files to ActiveRecord Objects
gem 'carrierwave'
gem 'mini_magick'

# Use AWS for Attachment Storage
gem 'fog'

gem 'cancan' # for authorization

gem 'simple_form'

gem 'kaminari'

gem 'copycopter_client'

# Use thin instead of Webrick
gem 'thin', require: false

# Texticle enables easy access to native PGSQL full-text searching, also see https://github.com/Casecommons/pg_search if this one sucks
gem 'texticle', :require => 'texticle/rails'

# For the screen-scraping component
gem 'nokogiri'
gem 'mechanize'

gem 'rails_admin', git: 'https://github.com/rtlong/rails_admin.git'

gem 'redis'

# Use Redis to do caching, i18n, and sessions
git 'https://github.com/jodosha/redis-store.git' do
  gem 'redis-store'
  gem 'redis-rails'
  gem 'redis-i18n'
  gem 'redis-rack-cache'
end

# For background tasks (like scraping the MN DoLI website, or sending emails)
gem 'resque', git: 'https://github.com/rtlong/resque.git'
gem 'resque-retry'

# Clean up view logic
gem 'active_decorator'


# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'

  # Inject jQuery into the asset pipeline
  gem 'jquery-rails'
  gem 'formalize-rails'
  gem 'chosen-rails'

  gem 'bourbon'
end

group :production, :staging do
  gem 'newrelic_rpm'
end

group :development do
  gem 'tailor', require: false

  # Prints db schema tidbits in all the models, tests, and fixtures, also shows `rake routes` output in routes.rb.
  gem 'annotate', require: false

  # https://github.com/guard/guard # http://intridea.com/2011/8/25/hire-a-guard-for-your-project
  gem 'guard', require: false

  # Restart the Rails development server automatically
  gem 'guard-rails', require: false

  # Run the appropriate RSpec test(s) automatically
  gem 'guard-rspec', require: false

  # Annotate models/tests/fixtures/etc when db is modified and routes when routes.rb is changed
  gem 'guard-annotate', require: false

  gem 'guard-bundler', require: false

  gem 'guard-cucumber', require: false
  gem 'guard-spork', require: false
  gem 'guard-resque', require: false

  gem 'sass'


  # access the rails console right within the web browser
  gem 'rack-webconsole'

  # gem 'railroad', git: 'https://github.com/kirillrdy/railroad3.git' # bx railroad -a -i -o full_models.dot -M

  # To enumerate all TODO's and FIXME's in the code
  gem 'dnote'

  gem 'pry-rails'
  gem 'pry-doc'

  # For seeding my dev DB with fake data
  gem 'populator'
end

group :development, :test do
  gem 'cucumber-rails', require: false
  gem 'cucumber'
  gem 'spork'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
  gem 'launchy'
  gem 'quiet_assets'

  gem 'faker' # Used in some of the Factories to generate fake data; used in seeds.rb
end


# group :development, :staging do
#   gem 'whereuat', git: 'https://github.com/rtlong/whereuat.git'

# end

# Gems only for certain operating system environments.
#
# Avoid installing those which you don't need by adding, for example, `--without windows:linux`
# to your `bundle install` command. You should only need do this once, as it will be remembered.

# Mac OS X; commented out until we need them, since Heroku does not like these
# group :darwin do
#   # The filesystem event and system notifications that Guard wants, for OS X
#   gem 'growl_notify', require: false # Growl notifications
#   gem 'rb-fsevent', git: 'git://github.com/ttilley/rb-fsevent.git', branch: 'pre-compiled-gem-one-off', require: false # FSEvent support
# end

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