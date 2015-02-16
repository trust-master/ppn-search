source 'http://rubygems.org'
ruby '2.2.0'

gem 'rails', '> 4.0.0'
gem 'rack'
gem 'rake'

# Gems for deprecated Rails 3 features
gem 'rails-observers'
gem 'protected_attributes'

gem 'pg' # Use PostgreSQL

gem 'unicorn', require: false # Use Unicorn to serve the app

gem 'haml' # Write views in HAML

gem 'liquid' # Use liquid templates for User-editable templates, i.e. mailers, pages

gem 'mail' # send mails with ease
gem 'premailer' # make inline the CSS, create text-only versions, more fun stuff

gem 'redcarpet' # Use Markdown to parse Pages / Email templates

gem 'bcrypt', '~> 3.1.7' # To use ActiveModel has_secure_password

gem 'paperclip'
gem 'fog' # Use AWS for Attachment Storage

gem 'cancan' # very nice API for authorization

# making controllers stupidly clean
gem 'inherited_resources'
gem 'has_scope'
gem 'responders'

gem 'simple_form' # Form builder

gem 'kaminari' # Pagination helpers / scopes

gem 'textacular'

# gem 'squeel' # convience API for AR-scoping

gem 'counter_culture' # easy counter cache columns

gem 'activeadmin', # Pretty admin interface made easy
  git: 'https://github.com/rtlong/active_admin.git' # my fork, for various fixes / mods

gem 'attribute_normalizer' # Normalize attributes before saving (strip, nullify blanks, custom formatting, etc.)

gem 'surus' # Use PostgreSQL's native Array and HStore data types in AR

gem 'enumerize' # Enumerated attributes made easy

gem 'paper_trail' # Keep a log of previous versions of AR models

gem 'redis' # Connect to Redis in-memory key/value store

# redis-store provides a full set of stores (Cache, I18n, Session, HTTP Cache). It natively supports
# object marshalling, timeouts, single or multiple nodes and namespaces.
gem 'redis-store' # wrapper gem
gem 'redis-rails' # provides a Rails interface to the above
gem 'redis-i18n' # provides a backend for I18n.
gem 'redis-rack-cache' # provides a Redis-backed store for Rack::Cache

gem 'sidekiq'

# For the screen-scraping component
gem 'nokogiri' # HTML/XML parser
gem 'mechanize' # API wrapper to work with nokogiri more easily

gem 'active_decorator' # Clean up view logic

gem 'content_for_in_controllers' # bring content_for into the controller

gem 'airbrake_user_attributes' # send Exceptions to Errbit
gem 'airbrake'

# Compass provides SASS goodies, and some of it's helpers are used in the app code, so it can't be
# in the assets group
gem 'compass-rails'

# These are dependencies of Sidekiq-web:
gem 'slim'
gem 'sinatra', require: false

# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails', '>= 4.0.3' # version forced to fix interaction bug between sass and sprockets and compass
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'yui-compressor'
  gem 'jquery-rails' # Inject jQuery into the asset pipeline

  # Chosen is still being used, but it's my modified version, so we can't use chosen-rails till my change is merged in
  # gem 'chosen-rails' # chosen provides a nifty jQuery plugin to do empowered <select>s

  # SASS goodies
  gem 'bourbon'

  gem 'oily_png' # C extensions for generating PNGs - used by Compass for the CSS sprites
end

group :production, :stage do
  gem 'newrelic_rpm'
  gem 'newrelic-redis'
  gem 'rails_12factor'
end

group :development do
  gem 'foreman', require: false

  gem 'sass' # This is here so generators can use it

  # Pry replaces IRB
  gem 'pry-rails' # replace IRB for the rails console, automatically
  gem 'pry-doc' # the libraries needed to view ruby source method-info in Pr

  gem 'populator' # For seeding my dev DB with fake data

  gem 'spring', require: false
  gem 'spring-commands-rspec', require: false
end

group :development, :test do
  gem 'cucumber-rails', require: false
  gem 'cucumber', require: false
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'factory_girl_rails', require: false
  gem 'faker' # Used in some of the Factories to generate fake data; used in seeds.rb
end

group :development, :stage do
  gem 'replicate', require: false
  gem 'rack-mini-profiler'
end
